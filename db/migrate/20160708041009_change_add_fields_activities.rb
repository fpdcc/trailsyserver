class ChangeAddFieldsActivities < ActiveRecord::Migration[4.2]
  def change
  	add_column    :activities, :atype,         :string
  	remove_column :activities, :activity_type
  	remove_column :activities, :name
  	remove_column :activities, :parking_entrance_id
  	add_column    :activities, :aname, :string
  	add_column    :activities, :poi_info_id, :integer
  	add_column    :activities, :trail_info_id, :integer
  	add_column    :activities, :parking_info_id, :integer
  	remove_column :activities, :trailhead_id
  end
end
