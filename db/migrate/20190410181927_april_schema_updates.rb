class AprilSchemaUpdates < ActiveRecord::Migration[5.1]
  def change
    remove_column :pointsofinterests, :recreation_center, :integer, default: 0
    add_column :pointsofinterests, :fitness_stairs, :integer, default: 0

    add_column :trails_descs, :hours1, :string
    add_column :trails_descs, :hours2, :string
    add_column :trails_descs, :season1, :string
    add_column :trails_descs, :season2, :string
    add_column :trails_descs, :special_hours, :string
    add_column :trails_descs, :trail_subsystem_id, :integer

    add_column :trails_infos, :hiking, :integer, default: 0
    add_column :trails_infos, :biking, :integer, default: 0
    add_column :trails_infos, :equestrian, :integer, default: 0
    add_column :trails_infos, :cross_country, :integer, default: 0
    add_column :trails_infos, :no_dogs, :integer, default: 0
    add_column :trails_infos, :dog_leash, :integer, default: 0
    add_column :trails_infos, :trail_subsystem_id, :integer
    add_column :trails_infos, :trail_name, :string

    add_column :trail_systems, :trail_subsystem_id, :integer

    add_column :trail_subtrails, :trail_subsystem_id, :integer
  end
end
