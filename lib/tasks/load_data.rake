require 'csv'
require 'rgeo-geojson'



namespace :load do
  task :all => [:trails, :trailheads, :segments, :activities]

  task :all_csv => [:activitiesCSV, :poi_infos, :poi_amenities, :poi_descs, :names, :parking_entrances, :parking_entrance_infos, :pointsofinterests, :new_trails, :trails_infos, :poi_to_trails, :trails_descs, :picnicgroves, :expire_pages]
  
  desc "Expire page cache"
  task :expire_pages => :environment do
    ActionController::Base::expire_page("/")
    ActionController::Base::expire_page("/activities.json")
    ActionController::Base::expire_page("/activities.json.gz")
    ActionController::Base::expire_page("/picnicgroves.json")
    ActionController::Base::expire_page("/picnicgroves.json.gz")
    ActionController::Base::expire_page("/poi_infos.json")
    ActionController::Base::expire_page("/poi_infos.json.gz")
    ActionController::Base::expire_page("/trails_infos.json")
    ActionController::Base::expire_page("/trails_infos.json.gz")
    ActionController::Base::expire_page("/new_trails.json")
    ActionController::Base::expire_page("/new_trails.json.gz")
    Rails.logger.info("Removed page cache")
  end


  task :trails => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE trails")
    if ENV['TRAILS_INPUT']
      input_file_names = [ENV['TRAILS_INPUT']]
    else
      input_file_names = ["lib/data/named_trails.csv"]
    end
    input_file_names.each do |input_file_name|
      if input_file_name =~ /csv$/
        parsed_trails = Trail.parse_csv(input_file_name)
      elsif input_file_name =~ /json$/
        parsed_trails = Trail.parse_json(input_file_name)
      else
        parsed_trails = []
      end
      parsed_trails.each do |trail|
        p "#{trail.source.code}: #{trail.name}"
        if !trail.save
          p trail.errors.full_messages
        end
      end
    end
  end

  task :trailheads => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE trailheads")
    if ENV['TRAILHEADS_INPUT']
      input_file_names = [ENV['TRAILHEADS_INPUT']]
    else
      input_file_names = ["lib/trailheads.geojson"]
    end
    input_file_names.each do |input_file_name|
      parsed_trailheads = Trailhead.parse_geojson(input_file_name)
      parsed_trailheads.each do |trailhead|
        p "#{trailhead.source.code}: #{trailhead.name}"
        if !trailhead.save
          p trailhead.errors.full_messages
        end
      end
    end
  end

  task :segments => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE trailsegments")
    if ENV['SEGMENTS_INPUT']
      input_file_names = [ENV['SEGMENTS_INPUT']]
    else
      input_file_names = ["lib/trail_segments.geojson"]
    end
    input_file_names.each do |input_file_name|
      parsed_segments = Trailsegment.parse_geojson(input_file_name)
      parsed_segments.each do |segment|
        p "#{segment.source.code}: segment added."
        if !segment.save
          p segment.errors.full_messages
        end
      end
    end
  end

  task :activities => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE activities")
    if ENV['ACTIVITIES_INPUT']
      input_file_names = [ENV['ACTIVITIES_INPUT']]
    else
      input_file_names = ["lib/data/activities.geojson"]
    end
    input_file_names.each do |input_file_name|
      parsed_poi_infos = Activity.parse_geojson(input_file_name)
      parsed_poi_infos.each do |activity|
        p "#{activity.name}: activity added."
        if !activity.save
          p activity.errors.full_messages
        end
      end
    end
  end

  task :activitiesCSV => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE activities")

    if ENV['ACTIVITIES_INPUT']
      input_file_names = [ENV['ACTIVITIES_INPUT']]
    else
      input_file_names = ["lib/data/activities.csv"]
    end
    input_file_names.each do |input_file_name|
      parsed_poi_infos = Activity.parse_csv(input_file_name)
      parsed_poi_infos.each do |activity|
        p "#{activity.activities_id}: activity added."
        if !activity.save
          p activity.errors.full_messages
        end
      end
    end
  end

  task :poi_infos => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE poi_infos")
    # if ENV['ACTIVITIES_INPUT']
    #   input_file_names = [ENV['ACTIVITIES_INPUT']]
    # else
      input_file_names = ["lib/data/poi_infos.csv"]
    #end
    input_file_names.each do |input_file_name|
      parsed_poi_infos = PoiInfo.parse_csv(input_file_name)
      parsed_poi_infos.each do |poi_info|
        p "#{poi_info.poi_info_id}: poi_info added."
        if !poi_info.save
          p poi_info.errors.full_messages
        end
      end
    end
  end

  task :poi_amenities => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE poi_amenities")
    # if ENV['ACTIVITIES_INPUT']
    #   input_file_names = [ENV['ACTIVITIES_INPUT']]
    # else
      input_file_names = ["lib/data/poi_amenities.csv"]
    #end
    input_file_names.each do |input_file_name|
      parsed_poi_amenities = PoiAmenity.parse_csv(input_file_name)
      parsed_poi_amenities.each do |poi_amenity|
        p "#{poi_amenity.poi_amenity_id}: poi_amenity added."
        if !poi_amenity.save
          p poi_amenity.errors.full_messages
        end
      end
    end
  end

  task :poi_descs => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE poi_descs")
    # if ENV['ACTIVITIES_INPUT']
    #   input_file_names = [ENV['ACTIVITIES_INPUT']]
    # else
      input_file_names = ["lib/data/poi_descs.csv"]
    #end
    input_file_names.each do |input_file_name|
      parsed_items = PoiDesc.parse_csv(input_file_name)
      parsed_items.each do |item|
        p "#{item.poi_desc_id}: poi_desc added."
        if !item.save
          p item.errors.full_messages
        end
      end
    end
  end

  task :names => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE names")
    # if ENV['ACTIVITIES_INPUT']
    #   input_file_names = [ENV['ACTIVITIES_INPUT']]
    # else
      input_file_names = ["lib/data/names.csv"]
    #end
    input_file_names.each do |input_file_name|
      parsed_items = Name.parse_csv(input_file_name)
      parsed_items.each do |item|
        p "#{item.nameid}: name added."
        if !item.save
          p item.errors.full_messages
        end
      end
    end
  end

  task :parking_entrances => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE parking_entrances")
    # if ENV['ACTIVITIES_INPUT']
    #   input_file_names = [ENV['ACTIVITIES_INPUT']]
    # else
      input_file_names = ["lib/data/parking_entrances.csv"]
    #end
    input_file_names.each do |input_file_name|
      parsed_items = ParkingEntrance.parse_csv(input_file_name)
      parsed_items.each do |item|
        p "#{item.parking_entrance_id}: parking_entrance added."
        if !item.save
          p item.errors.full_messages
        end
      end
    end
  end

  task :parking_entrance_infos => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE parking_entrance_infos")
    # if ENV['ACTIVITIES_INPUT']
    #   input_file_names = [ENV['ACTIVITIES_INPUT']]
    # else
      input_file_names = ["lib/data/parking_entrance_infos.csv"]
    #end
    input_file_names.each do |input_file_name|
      parsed_items = ParkingEntranceInfo.parse_csv(input_file_name)
      parsed_items.each do |item|
        p "#{item.parking_info_id}: parking_entrance_info added."
        if !item.save
          p item.errors.full_messages
        end
      end
    end
  end

  task :pointsofinterests => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE pointsofinterests")
    # if ENV['ACTIVITIES_INPUT']
    #   input_file_names = [ENV['ACTIVITIES_INPUT']]
    # else
      input_file_names = ["lib/data/pointsofinterests.csv"]
    #end
    input_file_names.each do |input_file_name|
      parsed_items = Pointsofinterest.parse_csv(input_file_name)
      parsed_items.each do |item|
        p "#{item.pointsofinterest_id}: pointsofinterest added."
        if !item.save
          p item.errors.full_messages
        end
      end
    end
  end

  task :new_trails => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE new_trails")
    # if ENV['ACTIVITIES_INPUT']
    #   input_file_names = [ENV['ACTIVITIES_INPUT']]
    # else
      input_file_names = ["lib/data/new_trails.csv"]
    #end
    input_file_names.each do |input_file_name|
      parsed_items = NewTrail.parse_csv(input_file_name)
      parsed_items.each do |item|
        p "#{item.trails_id}: new_trail added."
        if !item.save
          p item.errors.full_messages
        end
      end
    end
  end

  task :trails_infos => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE trails_infos")
    # if ENV['ACTIVITIES_INPUT']
    #   input_file_names = [ENV['ACTIVITIES_INPUT']]
    # else
      input_file_names = ["lib/data/trails_infos.csv"]
    #end
    input_file_names.each do |input_file_name|
      parsed_items = TrailsInfo.parse_csv(input_file_name)
      parsed_items.each do |item|
        p "#{item.trail_info_id}: trail_info added."
        if !item.save
          p item.errors.full_messages
        end
      end
    end
  end

  task :poi_to_trails => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE poi_to_trails")
    # if ENV['ACTIVITIES_INPUT']
    #   input_file_names = [ENV['ACTIVITIES_INPUT']]
    # else
      input_file_names = ["lib/data/poi_to_trails.csv"]
    #end
    input_file_names.each do |input_file_name|
      parsed_items = PoiToTrail.parse_csv(input_file_name)
      parsed_items.each do |item|
        p "#{item.trail_info_id} - #{item.poi_info_id}: poi_to_trail added."
        if !item.save
          p item.errors.full_messages
        end
      end
    end
  end

  task :trails_descs => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE trails_descs")
    # if ENV['ACTIVITIES_INPUT']
    #   input_file_names = [ENV['ACTIVITIES_INPUT']]
    # else
      input_file_names = ["lib/data/trails_descs.csv"]
    #end
    input_file_names.each do |input_file_name|
      parsed_items = TrailsDesc.parse_csv(input_file_name)
      parsed_items.each do |item|
        p "#{item.trail_desc_id}: trails_desc added."
        if !item.save
          p item.errors.full_messages
        end
      end
    end
  end

  task :picnicgroves => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE picnicgroves")
    #Picnicgrofe.destroy_all
    # if ENV['ACTIVITIES_INPUT']
    #   input_file_names = [ENV['ACTIVITIES_INPUT']]
    # else
      input_file_names = ["lib/data/picnicgroves.csv"]
    #end
    input_file_names.each do |input_file_name|
      parsed_items = Picnicgrofe.parse_csv(input_file_name)
      parsed_items.each do |item|
        p "#{item.picnicgrove_id}: picnicgrove added."
        if !item.save
          p item.errors.full_messages
        end
      end
    end
  end
 
end
