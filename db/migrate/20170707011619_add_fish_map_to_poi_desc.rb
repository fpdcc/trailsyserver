class AddFishMapToPoiDesc < ActiveRecord::Migration
  def change
  	add_column :poi_descs, :fish_map, :string
  end
end
