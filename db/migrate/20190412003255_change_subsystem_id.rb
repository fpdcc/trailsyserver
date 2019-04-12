class ChangeSubsystemId < ActiveRecord::Migration[5.1]
  def change
    change_column :trail_systems, :trail_subsystem_id, :string
    change_column :trail_subtrails, :trail_subsystem_id, :string
    change_column :trails_infos, :trail_subsystem_id, :string
    change_column :trails_descs, :trail_subsystem_id, :string
  end
end
