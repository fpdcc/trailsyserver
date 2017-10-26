json.array!(@trails_descs) do |trails_desc|
  json.extract! trails_desc, :id, :trail_desc_id, :trail_subsystem, :alt_name, :trail_desc, :map_link, :map_link_spanish
  json.url trails_desc_url(trails_desc, format: :json)
end
