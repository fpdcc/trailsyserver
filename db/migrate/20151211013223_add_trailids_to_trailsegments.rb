class AddTrailidsToTrailsegments < ActiveRecord::Migration[4.2]
  def change
  	add_column :trailsegments, :trail_ids, :text, array: true, default: []
  end
end
