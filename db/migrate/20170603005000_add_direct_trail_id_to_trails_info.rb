class AddDirectTrailIdToTrailsInfo < ActiveRecord::Migration[4.2]
  def change
    add_column :trails_infos, :direct_trail_id, :string
  end
end
