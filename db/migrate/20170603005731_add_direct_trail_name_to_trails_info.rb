class AddDirectTrailNameToTrailsInfo < ActiveRecord::Migration[4.2]
  def change
    add_column :trails_infos, :direct_trail_name, :string
  end
end
