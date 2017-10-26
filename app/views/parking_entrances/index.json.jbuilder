json.array!(@parking_entrances) do |parking_entrance|
  json.extract! parking_entrance, :id, :parking_entrance_id, :geom
  json.url parking_entrance_url(parking_entrance, format: :json)
end
