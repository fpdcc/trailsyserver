class CreatePoiToTrails < ActiveRecord::Migration
  def change
    create_table :poi_to_trails do |t|
      t.integer :trail_info_id
      t.integer :poi_info_id
      t.decimal :distance

      t.timestamps null: false
    end
  end
end
