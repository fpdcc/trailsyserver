class AddFieldsToPoi < ActiveRecord::Migration[4.2]
  def change
  	add_column :pointsofinterests, :recreation_center, :integer
  	add_column :pointsofinterests, :bathroom_building_winter, :integer
  	add_column :pointsofinterests, :bathroom_building_summer, :integer
  	add_column :pointsofinterests, :bathroom_building_ada, :integer
  	add_column :pointsofinterests, :bathroom_portable_winter, :integer
  	add_column :pointsofinterests, :bathroom_portable_summer, :integer
  	add_column :pointsofinterests, :bathroom_portable_ada, :integer
  	add_column :pointsofinterests, :web_map_geom, :st_point, geographic: true
  end
end
