json.array!(@alertings) do |alerting|
  json.extract! alerting, :id, :alertable_type, :alertable_id, :alert_id, :starts_at, :ends_at, :created_by
  json.url alerting_url(alerting, format: :json)
end
