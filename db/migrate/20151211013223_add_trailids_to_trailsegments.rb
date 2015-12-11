class AddTrailidsToTrailsegments < ActiveRecord::Migration
  def change
  	add_column :trailsegments, :trail_ids, :text, array: true, default: []
  end
end
