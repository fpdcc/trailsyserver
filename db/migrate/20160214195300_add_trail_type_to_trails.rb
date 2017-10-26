class AddTrailTypeToTrails < ActiveRecord::Migration[4.2]
  def change
  	add_column :trails, :trail_type, :string
  end
end
