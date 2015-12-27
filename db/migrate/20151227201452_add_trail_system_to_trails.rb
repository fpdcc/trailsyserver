class AddTrailSystemToTrails < ActiveRecord::Migration
  def change
  	add_column :trails, :trail_system, :string
  	add_column :trails, :trail_color, :string
  end
end
