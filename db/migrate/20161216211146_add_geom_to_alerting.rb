class AddGeomToAlerting < ActiveRecord::Migration[4.2]
  def change
  	add_column :alertings, :geom, :st_point, geographic: true
  end
end
