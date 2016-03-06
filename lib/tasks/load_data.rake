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
      parsed_activities = Activity.parse_geojson(input_file_name)
      parsed_activities.each do |activity|
        p "#{activity.name}: activity added."
        if !activity.save
          p activity.errors.full_messages
        end
      end
    end
  end

 
end
