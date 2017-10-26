class AddAdditionalIndexes < ActiveRecord::Migration[5.1]
  def change
  	add_index :activities, :trail_info_id
  	add_index :alertings, :alert_id
  	add_index :alertings, :alertable_id
  	add_index :picnicgroves, :poi_info_id
  	add_index :pointsofinterests, :poi_info_id, unique: true
  	add_index :trail_subtrails, :subtrail_id, unique: true
  	add_index :trail_subtrails, :trail_subsystem
  	add_index :trail_systems, :trail_subsystem, unique: true
  	add_index :trails_infos, :trail_subsystem
  end
end
