json.array!(@alerts) do |alert|
  json.extract! alert, :id, :alert_type, :link

  json.description alert.full_desc

  json.start_date alert.starts_at.try(:strftime, "%m/%d/%Y")
  json.end_date alert.ends_at.try(:strftime, "%m/%d/%Y")

  # Nested trail_system
  json.trail_systems alert.trail_systems.pluck(:trail_subsystem)

  # Nested pointsofinterest
  json.pointsofinterests alert.pointsofinterests.pluck(:id)
  
end
