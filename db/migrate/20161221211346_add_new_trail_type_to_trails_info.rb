class AddNewTrailTypeToTrailsInfo < ActiveRecord::Migration
  def change
  	add_column :trails_infos, :trail_name_type, :string
  end
end
