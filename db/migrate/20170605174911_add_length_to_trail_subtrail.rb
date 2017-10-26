class AddLengthToTrailSubtrail < ActiveRecord::Migration[4.2]
  def change
    add_column :trail_subtrails, :length_mi, :decimal
  end
end
