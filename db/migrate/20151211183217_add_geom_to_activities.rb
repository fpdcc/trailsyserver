class AddGeomToActivities < ActiveRecord::Migration
  def change
  	add_column :activities, :geom, :point, geographic: true
  end
end
