require 'csv'
require 'rgeo-geojson'



namespace :load do
  task :all => [:trails, :trailheads, :segments]
  
  task :trails => :environment do
    Trail.destroy_all
    input_file_name = ENV["TRAIL_INPUT"] || "lib/summit_traildata.csv"
    p input_file_name
    CSV.foreach(input_file_name, headers: true) do |row|
      @trail = Trail.new
      row.headers.each do |header|
        property_key = header.downcase
        property_value = row[header]
        # don't include the WKT field -- we've got geom
        if property_key == "wkt" 
          next
          # updates for DS 0.3.1
        elsif property_key == "horses"
          property_key = "equestrian"
        elsif property_key == "bikes"
          property_key = "roadbike"
        elsif property_key == "print_map_url"
          property_key = "map_url"
        elsif property_key == "steward"
          organization = Organization.where(code: property_value).first
          if organization.nil?
            p "steward '#{property_value}' not found."
            property_value = nil
          else
            p "steward #{organization} found."
            property_value = organization
          end
        elsif property_key == "source"
          organization = Organization.where(code: property_value).first
          if organization.nil?
            p "source '#{property_value}' not found."
            property_value = nil
          else
            p "source #{organization} found."
            property_value = organization
          end
        end
        # send it to the trail object
        if @trail.attributes.has_key? property_key
          print "#{property_key.to_sym}=", property_value, "\n"
          @trail.send "#{property_key.to_sym}=", property_value
        # not entirely sure why I need to pull these out. "source"/"steward" is an AR Relation,
        # but doesn't show up with "has_key" 
        # there must be an AR equivalent of has_key to use instead
        elsif property_key == "source"
          @trail.source = property_value
        elsif property_key == "steward"
          @trail.steward = property_value
        else 
          p "#{@trail.name}: warning: '#{property_key}' in input, but not in Trail model."
        end
      end
      # @trail.source = row["source"]
      print "."
      @trail.save
    end
  end

  task :trailheads => :environment do
    input_file_name = ENV["TRAILHEADS_INPUT"] || "lib/summit_trailheads.geojson"
    File.open(input_file_name) do |geojson|
      feature_collection = RGeo::GeoJSON.decode(geojson, { geo_factory: RGeo::Geographic.spherical_factory(:srid => 4326), json_parser: :json})
      feature_collection.each do |feature|
        @trailhead = Trailhead.new
        feature.properties.each do |property|
          property_key = property[0].downcase
          property_value = property[1]
          if property_key == 'wkt'
            next 
          end
          if @trailhead.attributes.has_key? property_key
            @trailhead.send "#{property_key.to_sym}=", property_value
          else
            p "warning: #{property_key} in input, but not in Trailhead model"
          end
        end
        # p feature.geometry
        @trailhead.geom = feature.geometry
        print "."
        if @trailhead.steward.nil?
          @trailhead.steward == @trailhead.source
        end
        if !@trailhead.save
          p "Error!: #{@trailhead.errors.full_messages}"
          p @trailhead.inspect
          puts "\n"
        end
      end
    end  
  end

  task :segments => :environment do
    input_file_name = ENV["SEGMENTS_INPUT"] || "lib/summit_trailsegments.geojson"
    File.open(input_file_name) do |geojson|
      feature_collection = RGeo::GeoJSON.decode(geojson, { geo_factory: RGeo::Geographic.spherical_factory(:srid => 4326), json_parser: :json})
      feature_collection.each do |feature|
        @segment = Trailsegment.new
        feature.properties.each do |property|
          property_key = property[0].downcase
          property_value = property[1]
          if property_key == 'wkt'
            next
          end
          if @segment.attributes.has_key? property_key
            @segment.send "#{property_key.to_sym}=", property_value
          else
            p "warning: #{property_key} in input, but not in Segment model"
          end
        end
        @segment.geom = feature.geometry
        if !@segment.save
          p "Error!: #{@segment.errors.full_messages}"
          p @segment.inspect
        end
      end
    end
  end
end
