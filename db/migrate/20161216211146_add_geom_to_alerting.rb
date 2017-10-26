class AddGeomToAlerting < ActiveRecord::Migration
  def change
  	add_column :alertings, :geom, :st_point, geographic: true
  end
end
