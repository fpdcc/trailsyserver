json.array!(@alerts) do |alert|
  json.extract! alert, :id, :alert_id, :alert_type, :description, :link, :created_by
  json.url alert_url(alert, format: :json)
end
