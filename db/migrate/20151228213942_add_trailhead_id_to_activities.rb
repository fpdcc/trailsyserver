class AddTrailheadIdToActivities < ActiveRecord::Migration[4.2]
  def change
  	add_column :activities, :trailhead_id, :string
  end
end
