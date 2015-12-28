class AddTrailheadIdToActivities < ActiveRecord::Migration
  def change
  	add_column :activities, :trailhead_id, :string
  end
end
