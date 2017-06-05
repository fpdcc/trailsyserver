class AddLengthToTrailSubtrail < ActiveRecord::Migration
  def change
    add_column :trail_subtrails, :length_mi, :decimal
  end
end
