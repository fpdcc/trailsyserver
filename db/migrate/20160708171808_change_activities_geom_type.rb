class ChangeActivitiesGeomType < ActiveRecord::Migration
  def change
  	remove_column :activities, :geom
  	add_column    :activities, :geom, :st_point, geographic: true
  end
end
