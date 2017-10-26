class AddGeomToActivities < ActiveRecord::Migration[4.2]
  def change
  	add_column :activities, :geom, :point, geographic: true
  end
end
