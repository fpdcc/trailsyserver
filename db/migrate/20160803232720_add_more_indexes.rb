class AddMoreIndexes < ActiveRecord::Migration
  def change
  	add_index :poi_descs, :poi_info_id, unique: true
  	add_index :poi_amenities, :poi_info_id, unique: true
  	add_index :activities, :poi_info_id
  	add_index :poi_to_trails, :poi_info_id
  	add_index :poi_to_trails, :trail_info_id
  	add_index :trails_descs, :trail_subsystem
  	add_index :trails_infos, :web_trail
  	add_index :trails_infos, :trails_id
  	add_index :picnicgroves, :status
  	add_index :parking_entrance_infos, :parking_entrance_id, unique: true
  end
end
