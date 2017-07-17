class AddDirectTrailNameToTrailsInfo < ActiveRecord::Migration
  def change
    add_column :trails_infos, :direct_trail_name, :string
  end
end
