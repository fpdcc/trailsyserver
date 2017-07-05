json.array!(@alerts) do |alert|
  json.extract! alert, :id, :alert_type, :link

  json.description alert.full_desc

  json.start_date alert.starts_at.try(:strftime, "%m/%d/%Y")
  json.end_date alert.ends_at.try(:strftime, "%m/%d/%Y")

  # Nested trail_system
  json.trail_systems alert.trail_systems do |trail_system|
    json.name trail_system.name
  end

  # Nested trail_subtrail
  # json.trail_subtrails alert.trail_subtrails do |trail_subtrail|
  #   json.name trail_subtrail.subtrail_name
  # end

  # Nested pointsofinterest
  json.pointsofinterests alert.pointsofinterests do |pointsofinterest|
    json.id pointsofinterest.id
    json.name pointsofinterest.name
  end
  #json.url alert_url(alert, format: :json)
end
