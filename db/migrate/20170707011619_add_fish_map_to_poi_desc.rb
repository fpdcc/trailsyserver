class AddFishMapToPoiDesc < ActiveRecord::Migration[4.2]
  def change
  	add_column :poi_descs, :fish_map, :string
  end
end
