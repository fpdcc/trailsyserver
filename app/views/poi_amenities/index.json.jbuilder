json.array!(@poi_amenities) do |poi_amenity|
  json.extract! poi_amenity, :id, :poi_info_id, :ada, :bike_parking, :bike_rental, :birding, :boat_ramp, :boat_rental, :camping, :canoe, :comfortstation, :cross_country, :cycling, :disc_golf, :dog_friendly, :dog_leash, :drinkingwater, :drone, :ecological, :equestrian, :fishing, :ice_fishing, :gas_powered, :golf, :hiking, :indoor_rental, :large_capacity, :m_airplane, :m_boat, :nature_center, :natureplay, :no_alcohol, :no_parking, :overlook, :pavillion, :picnic_grove, :shelter, :skating_ice, :skating_inline, :sledding, :snowmobile, :swimming, :toboggan, :volunteer, :zip_line, :poi_amenity_id
  json.url poi_amenity_url(poi_amenity, format: :json)
end