class AddNewTrailTypeToTrailsInfo < ActiveRecord::Migration[4.2]
  def change
  	add_column :trails_infos, :trail_name_type, :string
  end
end
