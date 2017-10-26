class AddDetailsToTrailheads < ActiveRecord::Migration[4.2]
  def change
  	add_column :trailheads, :hours1, :string
  	add_column :trailheads, :hours2, :string
  	add_column :trailheads, :phone, :string
  	add_column :trailheads, :description, :text
  	add_column :trailheads, :web_link, :string
  	add_column :trailheads, :map_link, :string
  	add_column :trailheads, :map_link_spanish, :string
  	add_column :trailheads, :vol_link, :string
  	add_column :trailheads, :vol_link2, :string
  	add_column :trailheads, :picnic_link, :string
  	add_column :trailheads, :event_link, :string
  end
end
