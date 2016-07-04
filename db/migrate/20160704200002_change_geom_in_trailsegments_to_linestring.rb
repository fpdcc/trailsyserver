class ChangeGeomInTrailsegmentsToLinestring < ActiveRecord::Migration
 def change
 	remove_column :trailsegments, :geom
    add_column :trailsegments, :geom, :line_string, geographic: true
  end

end