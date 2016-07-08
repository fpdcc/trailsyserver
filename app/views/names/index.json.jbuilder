json.array!(@names) do |name|
  json.extract! name, :id, :nameid, :name, :old_id
  json.url name_url(name, format: :json)
end
