class AddFieldsToModels < ActiveRecord::Migration
  def change
  	add_column :pointsofinterests, :maintenance_div, :string
  	add_column :pointsofinterests, :pavilion, :integer
  	add_column :parking_entrances, :parking_info_id, :integer
  	add_column :parking_entrances, :name, :string
  	add_column :parking_entrances, :web_street_addr, :string
  	add_column :parking_entrances, :web_muni_addr, :string
  	add_column :parking_entrances, :web_poi, :string
  	add_column :trails_infos, :direction, :string
  end
end
