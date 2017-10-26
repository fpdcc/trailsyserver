class CreateTrailsInfos < ActiveRecord::Migration
  def change
    create_table :trails_infos do |t|
      t.string :trail_system, null: false
      t.string :trail_subsystem, null: false
      t.string :trail_color
      t.string :trail_surface
      t.string :trail_type
      t.string :trail_difficulty
      t.string :regional_trail_name
      t.string :trail_desc
      t.string :gps
      t.string :comment
      t.string :alt_name
      t.string :cambr_name
      t.string :on_street
      t.string :crossing_type
      t.string :unrecognized, null: false
      t.decimal :length_mi
      t.integer :trails_id, null: false
      t.string :off_fpdcc, null: false
      t.string :web_trail, null: false
      t.string :maintenance
      t.decimal :length_ft
      t.integer :trail_info_id

      t.timestamps null: false
    end
  end
end
