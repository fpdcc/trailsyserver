class AddTrailNameToSubtrail < ActiveRecord::Migration[5.1]
  def change
    add_column :trail_subtrails, :trail_name, :string
  end
end
