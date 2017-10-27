class AddOpenTrails11FieldsToTrailheads < ActiveRecord::Migration[4.2]
  def change
  	add_column :trailheads, :segment_ids, :text, array: true, default: []
  	add_column :trailheads, :trailhead_id, :string
  	add_column :trailheads, :trail_ids, :text, array: true, default: []
  end
end
