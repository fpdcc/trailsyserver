class CreatePoiAmenities < ActiveRecord::Migration
  def change
    create_table :poi_amenities do |t|
      t.integer :poi_info_id
      t.integer :ada
      t.integer :bike_parking
      t.integer :bike_rental
      t.integer :birding
      t.integer :boat_ramp
      t.integer :boat_rental
      t.integer :camping
      t.integer :canoe
      t.integer :comfortstation
      t.integer :cross_country
      t.integer :cycling
      t.integer :disc_golf
      t.integer :dog_friendly
      t.integer :dog_leash
      t.integer :drinkingwater
      t.integer :drone
      t.integer :ecological
      t.integer :equestrian
      t.integer :fishing
      t.integer :ice_fishing
      t.integer :gas_powered
      t.integer :golf
      t.integer :hiking
      t.integer :indoor_rental
      t.integer :large_capacity
      t.integer :m_airplane
      t.integer :m_boat
      t.integer :nature_center
      t.integer :natureplay
      t.integer :no_alcohol
      t.integer :no_parking
      t.integer :overlook
      t.integer :pavillion
      t.integer :picnic_grove
      t.integer :shelter
      t.integer :skating_ice
      t.integer :skating_inline
      t.integer :sledding
      t.integer :snowmobile
      t.integer :swimming
      t.integer :toboggan
      t.integer :volunteer
      t.integer :zip_line
      t.integer :poi_amenity_id

      t.timestamps null: false
    end
  end
end
