json.array!(@new_trails) do |new_trail|
  json.extract! new_trail, :id, :trails_id, :geom
  json.url new_trail_url(new_trail, format: :json)
end
