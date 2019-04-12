class RemoveIndex < ActiveRecord::Migration[5.1]
  def change
    remove_index :trail_systems, :trail_subsystem

  end
end
