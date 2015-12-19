class AddAmenitiesToTrailheads < ActiveRecord::Migration
  def change
  	add_column :trailheads, :large_capacity, :int
  	add_column :trailheads, :gas_powered, :int
  	add_column :trailheads, :boat_rental, :int
  	add_column :trailheads, :picnic_grove, :int
  	add_column :trailheads, :shelter, :int
  	add_column :trailheads, :hiking, :int
  	add_column :trailheads, :cycling, :int
  	add_column :trailheads, :in_line_sk, :int
  	add_column :trailheads, :cross_country, :int
  	add_column :trailheads, :ecological, :int
  	add_column :trailheads, :equestrian, :int
  	add_column :trailheads, :birding, :int
  	add_column :trailheads, :fishing, :int
  	add_column :trailheads, :canoe, :int
  	add_column :trailheads, :snowmobile, :int
  	add_column :trailheads, :m_boat, :int
  	add_column :trailheads, :m_airplace, :int
  	add_column :trailheads, :camping, :int
  	add_column :trailheads, :dog_friendly, :int
  	add_column :trailheads, :sledding, :int
  	add_column :trailheads, :toboggan_a, :int
  	add_column :trailheads, :boat_ramp, :int
  	add_column :trailheads, :nature_center, :int
  	add_column :trailheads, :swimming, :int
  	add_column :trailheads, :golf, :int
  	add_column :trailheads, :no_alcohol, :int
  	add_column :trailheads, :no_parking, :int
  	add_column :trailheads, :comfortstation, :int
  	add_column :trailheads, :drinkingwater, :int
  	add_column :trailheads, :natureplay, :int
  	add_column :trailheads, :ada, :int
  	add_column :trailheads, :pavillion, :int
  	add_column :trailheads, :trailacces, :int
  end
end
