json.array!(@trail_systems) do |trail_system|
  json.extract! trail_system, :id, :trail_subsystem
  json.url trail_system_url(trail_system, format: :json)
end
