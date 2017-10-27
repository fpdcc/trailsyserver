class AddTrailSystemToTrails < ActiveRecord::Migration[4.2]
  def change
  	add_column :trails, :trail_system, :string
  	add_column :trails, :trail_color, :string
  end
end
