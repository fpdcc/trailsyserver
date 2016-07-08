json.array!(@poi_descs) do |poi_desc|
  json.extract! poi_desc, :id, :poi_info_id, :hours1, :hours2, :phone, :description, :web_link, :map_link, :map_link_spanish, :vol_link, :vol_link2, :picnic_link, :event_link, :custom_link, :season1, :season2, :special_hours, :special_description, :special_link, :photo_link, :poi_desc_id
  json.url poi_desc_url(poi_desc, format: :json)
end
