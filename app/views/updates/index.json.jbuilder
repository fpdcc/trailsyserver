json.array!(@updates) do |update|
  json.extract! update, :id
  json.url update_url(update, format: :json)
end
