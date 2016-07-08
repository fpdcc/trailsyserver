class CreateParkingEntranceInfos < ActiveRecord::Migration
  def change
    create_table :parking_entrance_infos do |t|
      t.integer :parking_entrance_id
      t.string :multi_entrance
      t.string :private_lot
      t.integer :lot
      t.string :zone_name
      t.string :area_name
      t.string :fpd_uid
      t.string :point_type
      t.string :parking_entrance_addr
      t.string :trailaccess
      t.integer :nameid
      t.integer :parking_info_id
      t.string :entrance_closed

      t.timestamps null: false
    end
  end
end
