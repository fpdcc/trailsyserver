class AddSecondaryTrailIdsToTrailsegments < ActiveRecord::Migration
  def change
  	add_column :trailsegments, :secondary_trail_ids, :text, array: true, default: []
  end
end
