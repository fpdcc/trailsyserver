json.array!(@pointsofinterests) do |pointsofinterest|
  json.extract! pointsofinterest, :id, :pointsofinterest_id, :geom
  json.url pointsofinterest_url(pointsofinterest, format: :json)
end
