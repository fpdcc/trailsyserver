json.array!(@parking_entrance_infos) do |parking_entrance_info|
  json.extract! parking_entrance_info, :id, :parking_entrance_id, :multi_entrance, :private_lot, :lot, :zone_name, :area_name, :fpd_uid, :point_type, :parking_entrance_addr, :trailaccess, :nameid, :parking_info_id, :entrance_closed
  json.url parking_entrance_info_url(parking_entrance_info, format: :json)
end
