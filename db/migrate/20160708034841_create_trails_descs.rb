class CreateTrailsDescs < ActiveRecord::Migration
  def change
    create_table :trails_descs do |t|
      t.integer :trail_desc_id, null: false
      t.string :trail_subsystem
      t.string :alt_name
      t.string :trail_desc
      t.string :map_link
      t.string :map_link_spanish

      t.timestamps null: false
    end
  end
end
