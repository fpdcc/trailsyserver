class AddDirectTrailIdToTrailsInfo < ActiveRecord::Migration
  def change
    add_column :trails_infos, :direct_trail_id, :string
  end
end
