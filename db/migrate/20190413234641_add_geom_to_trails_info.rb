class AddGeomToTrailsInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :trails_infos, :geom, :line_string, geographic: true
  end
end
