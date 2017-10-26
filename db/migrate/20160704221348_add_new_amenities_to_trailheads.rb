class AddNewAmenitiesToTrailheads < ActiveRecord::Migration
  def change
  	add_column :trailheads, :bike_parking, :integer
  	add_column :trailheads, :bike_rental, :integer
  	add_column :trailheads, :disc_golf, :integer
  	add_column :trailheads, :dog_leash, :integer
  	add_column :trailheads, :drone, :integer
  	add_column :trailheads, :ice_fishing, :integer
  	add_column :trailheads, :indoor_rental, :integer
  	add_column :trailheads, :overlook, :integer
  	add_column :trailheads, :skating_ice, :integer
  	add_column :trailheads, :skating_inline, :integer
  	add_column :trailheads, :toboggan, :integer
  	add_column :trailheads, :volunteer, :integer
  	add_column :trailheads, :zip_line, :integer
  	add_column :trailheads, :custom_link, :string
  end
end
