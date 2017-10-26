class CreatePicnicgroves < ActiveRecord::Migration
  def change
    create_table :picnicgroves do |t|
      t.integer :picnicgrove_id, null: false
      t.string :preserve_name
      t.integer :grove
      t.string :division
      t.integer :capacity
      t.string :large_capacity
      t.string :type
      t.string :location
      t.string :status
      t.string :fpd_uid
      t.integer :poi_info_id
      t.st_point :geom

      t.timestamps null: false
    end

    add_index :picnicgroves, :picnicgrove_id, unique: true
  end
end
