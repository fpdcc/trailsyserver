json.array!(@alerts) do |alert|
  json.extract! alert, :id, :alert_id, :alert_type, :description, :link, :created_by

  # Nested trail_system
  json.trail_systems alert.trail_systems do |trail_system|
    json.name trail_system.name
  end

  # Nested trail_subtrail
  json.trail_subtrails alert.trail_subtrails do |trail_subtrail|
    json.name trail_subtrail.subtrail_name
  end
  # Nested pointsofinterest
  json.pointsofinterests alert.pointsofinterests do |pointsofinterest|
    json.id pointsofinterest.id
    json.name pointsofinterest.name
  end
  #json.url alert_url(alert, format: :json)
end
