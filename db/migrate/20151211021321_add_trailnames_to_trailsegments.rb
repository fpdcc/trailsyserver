class AddTrailnamesToTrailsegments < ActiveRecord::Migration
  def change
  	add_column :trailsegments, :trail_names, :text, array: true, default: []
  end
end
