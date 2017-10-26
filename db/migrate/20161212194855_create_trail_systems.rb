class CreateTrailSystems < ActiveRecord::Migration[4.2]
  def change
    create_table :trail_systems do |t|
      t.string :trail_subsystem

      t.timestamps null: false
    end
  end
end
