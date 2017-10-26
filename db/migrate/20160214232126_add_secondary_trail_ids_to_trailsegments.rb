class AddSecondaryTrailIdsToTrailsegments < ActiveRecord::Migration[4.2]
  def change
  	add_column :trailsegments, :secondary_trail_ids, :text, array: true, default: []
  end
end
