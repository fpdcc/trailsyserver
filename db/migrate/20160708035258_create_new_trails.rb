class CreateNewTrails < ActiveRecord::Migration
  def change
    create_table :new_trails do |t|
      t.integer :trails_id
      t.line_string :geom, geographic: true

      t.timestamps null: false
    end
  end
end
