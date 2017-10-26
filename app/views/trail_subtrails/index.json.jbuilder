json.array!(@trail_subtrails) do |trail_subtrail|
  json.extract! trail_subtrail, :id
  json.url trail_subtrail_url(trail_subtrail, format: :json)
end
