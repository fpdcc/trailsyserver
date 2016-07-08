require 'csv'
require 'rgeo-geojson'



namespace :load do
  task :all => [:trails, :trailheads, :segments, :activities]
  
  task :trails => :environment do
    Trail.destroy_all
    if ENV['TRAILS_INPUT']
      input_file_names = [ENV['TRAILS_INPUT']]
    else
      input_file_names = ["lib/named_trails.csv"]
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
    Trailhead.destroy_all
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
    Trailsegment.destroy_all
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
    Activity.destroy_all
    if ENV['ACTIVITIES_INPUT']
      input_file_names = [ENV['ACTIVITIES_INPUT']]
    else
      input_file_names = ["lib/activities.geojson"]
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
    Activity.destroy_all
    if ENV['ACTIVITIES_INPUT']
      input_file_names = [ENV['ACTIVITIES_INPUT']]
    else
      input_file_names = ["lib/activities.csv"]
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
    PoiInfo.destroy_all
    # if ENV['ACTIVITIES_INPUT']
    #   input_file_names = [ENV['ACTIVITIES_INPUT']]
    # else
      input_file_names = ["lib/poi_infos.csv"]
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
    PoiAmenity.destroy_all
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
    PoiDesc.destroy_all
    # if ENV['ACTIVITIES_INPUT']
    #   input_file_names = [ENV['ACTIVITIES_INPUT']]
    # else
      input_file_names = ["lib/data/poi_descs.csv"]
    #end
    input_file_names.each do |input_file_name|
      parsed_items = PoiDesc.parse_csv(input_file_name)
      parsed_items.each do |item|
        p "#{item.poi_desc_id}: item added."
        if !item.save
          p item.errors.full_messages
        end
      end
    end
  end

  task :names => :environment do
    Name.destroy_all
    # if ENV['ACTIVITIES_INPUT']
    #   input_file_names = [ENV['ACTIVITIES_INPUT']]
    # else
      input_file_names = ["lib/data/names.csv"]
    #end
    input_file_names.each do |input_file_name|
      parsed_items = Name.parse_csv(input_file_name)
      parsed_items.each do |item|
        p "#{item.nameid}: item added."
        if !item.save
          p item.errors.full_messages
        end
      end
    end
  end

  task :parking_entrances => :environment do
    ParkingEntrance.destroy_all
    # if ENV['ACTIVITIES_INPUT']
    #   input_file_names = [ENV['ACTIVITIES_INPUT']]
    # else
      input_file_names = ["lib/data/parking_entrances.csv"]
    #end
    input_file_names.each do |input_file_name|
      parsed_items = ParkingEntrance.parse_csv(input_file_name)
      parsed_items.each do |item|
        p "#{item.parking_entrance_id}: item added."
        if !item.save
          p item.errors.full_messages
        end
      end
    end
  end

  task :parking_entrance_infos => :environment do
    ParkingEntranceInfo.destroy_all
    # if ENV['ACTIVITIES_INPUT']
    #   input_file_names = [ENV['ACTIVITIES_INPUT']]
    # else
      input_file_names = ["lib/data/parking_entrance_infos.csv"]
    #end
    input_file_names.each do |input_file_name|
      parsed_items = ParkingEntranceInfo.parse_csv(input_file_name)
      parsed_items.each do |item|
        p "#{item.parking_info_id}: item added."
        if !item.save
          p item.errors.full_messages
        end
      end
    end
  end

  task :pointsofinterests => :environment do
    Pointsofinterest.destroy_all
    # if ENV['ACTIVITIES_INPUT']
    #   input_file_names = [ENV['ACTIVITIES_INPUT']]
    # else
      input_file_names = ["lib/data/pointsofinterests.csv"]
    #end
    input_file_names.each do |input_file_name|
      parsed_items = Pointsofinterest.parse_csv(input_file_name)
      parsed_items.each do |item|
        p "#{item.pointsofinterest_id}: item added."
        if !item.save
          p item.errors.full_messages
        end
      end
    end
  end
 
end
