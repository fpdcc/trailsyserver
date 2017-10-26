class ChangePoiInfoIdToString < ActiveRecord::Migration
  def change
  	change_column :pointsofinterests, :poi_info_id, :string
  	change_column :activities, :poi_info_id, :string
  	change_column :picnicgroves, :poi_info_id, :string
  	change_column :poi_descs, :poi_info_id, :string
  end
end
