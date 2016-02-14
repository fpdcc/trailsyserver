class AddTrailTypeToTrails < ActiveRecord::Migration
  def change
  	add_column :trails, :trail_type, :string
  end
end
