json.array!(@poi_infos) do |poi_info|
  json.extract! poi_info, :id, :poi_info_id, :point_type, :addr, :zip, :zipmuni, :municipality, :public_access, :latitude, :longitude, :commdist, :zone_name, :zonemapno, :dwmapno, :nameid, :pointsofinterest_id, :fpd_uid, :web_poi, :web_street_addr, :web_muni_addr, :parking_connection_id, :parking_info_id, :alt_nameid, :alt2_nameid
  json.url poi_info_url(poi_info, format: :json)
end
