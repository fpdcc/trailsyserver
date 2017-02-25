class AddSegmentTypeToTrailInfo < ActiveRecord::Migration
  def change
  	remove_column :trails_infos, :trail_name_type
  	add_column :trails_infos, :segment_type, :string
  end
end
