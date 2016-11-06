class Activity < ActiveRecord::Base
  self.primary_key = 'activities_id'

  #belongs_to :trailhead, foreign_key: "trailhead_id"
  belongs_to :poi_info, foreign_key: :poi_info_id, primary_key: :poi_info_id
  has_one :name, foreign_key: :nameid, primary_key: :nameid
  #set_rgeo_factory_for_column(:geom, RGeo::Geographic.spherical_factory(:srid => 4326))

  #validates :name, presence: true

  def self.parse_geojson(file)
    if file.class == ActionDispatch::Http::UploadedFile
      feature_collection = RGeo::GeoJSON.decode(File.read(file.path), json_parser: :json)
    elsif file.class == String
      feature_collection = RGeo::GeoJSON.decode(File.new(file), json_parser: :json)
    elsif file.class == File
      feature_collection = RGeo::GeoJSON.decode(file, json_parser: :json)
    end
    parsed_activities = []
    feature_collection.each do |feature|
      new_activity = Activity.new
      feature.properties.each do |property|
        key = property[0].downcase
        value = property[1]
        next if key == "id"
        unless value.nil?
          if value.to_s.downcase == "yes" || value == "Y"
            value = "y"
          end
          if value.to_s.downcase == "no" || value == "N"
            value = "n"
          end
        end
        if new_activity.attributes.has_key? key
          new_activity[key] = value
        # elsif key == "source"
        #   new_activity.source = Organization.find_by code: value
        # elsif key == "steward"
        #   new_activity.steward = Organization.find_by code: value
        end
      end
      new_activity["geom"] = feature.geometry
      # if new_activity.steward.nil?
      #   new_activity.steward = new_activity.source
      # end
      parsed_activities.push new_activity
    end
    parsed_activities
  end

  def self.parse_csv(file)
    parsed_activities = []
    if file.class == ActionDispatch::Http::UploadedFile
      file_ident = file.path
    else
      file_ident = file
    end

    # if the encoding is bad, assume windows-1252
    
    contents = File.read(file_ident)
    unless contents.valid_encoding?
      contents.encode!("utf-8", "windows-1252", :invalid => :replace)
    end

    CSV.parse(contents, headers: true, header_converters: :downcase) do |row|
      new_activity = Activity.new
      next if (row.to_s =~ /^source/)

      row.headers.each do |header|
        value = row[header]
        next if header == "id"
        unless value.nil?
          value = value.squish
          if value.to_s.downcase == "yes" || value == "Y"
            value = "y"
          end
          if value.to_s.downcase == "no" || value == "N"
            value = "n"
          end
        end
        # next if header == "source"
        if new_activity.attributes.has_key? header
          new_activity[header] = value
        # elsif header == "source"
        #new_activity.source = Organization.find_by code: value
        # elsif header == "steward"
        #   new_activity.steward = Organization.find_by code: value
        end
      end
      parsed_activities.push new_activity
    end
    parsed_activities
  end

  def self.parse(file)
    # if (file.original_filename =~ /zip$/)
    #   return self.parse_shapefile(file)
    if (file.original_filename =~ /json$/)
      return self.parse_geojson(file)
    end
  end

end
