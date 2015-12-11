json.array!(@activities) do |activity|
  json.extract! activity, :id, :activities_id, :type, :name, :parking_entrance_id, :nameid
  json.url activity_url(activity, format: :json)
end
