class ChangeGeomInTrailsegmentsToLinestring < ActiveRecord::Migration[4.2]
 def change
 	remove_column :trailsegments, :geom
    add_column :trailsegments, :geom, :line_string, geographic: true
  end

end