class AddIndexes < ActiveRecord::Migration[4.2]
  def change
  	add_index :activities, :activities_id, unique: true
  	#add_index :names, :nameid, unique: true
  	add_index :new_trails, :trails_id, unique: true
  	#add_index :parking_entrance_infos, :parking_info_id, unique: true
  	add_index :parking_entrances, :parking_entrance_id, unique: true
  	#add_index :poi_amenities, :poi_amenity_id, unique: true
  	add_index :poi_descs, :poi_desc_id, unique: true
  	#add_index :poi_infos, :poi_info_id, unique: true
  	add_index :pointsofinterests, :pointsofinterest_id, unique: true
  	add_index :trails_descs, :trail_desc_id, unique: true
  	add_index :trails_infos, :trail_info_id, unique: true
  end
end
