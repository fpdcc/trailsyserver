json.array!(@poi_to_trails) do |poi_to_trail|
  json.extract! poi_to_trail, :id, :trail_info_id, :poi_info_id, :distance
  json.url poi_to_trail_url(poi_to_trail, format: :json)
end
