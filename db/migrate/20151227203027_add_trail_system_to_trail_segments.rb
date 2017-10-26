class AddTrailSystemToTrailSegments < ActiveRecord::Migration[4.2]
  def change
  	add_column :trailsegments, :trail_systems, :text, array: true, default: []
  	add_column :trailsegments, :trail_colors, :text, array: true, default: []
  end
end
