class CreatePoiInfos < ActiveRecord::Migration
  def change
    create_table :poi_infos do |t|
      t.integer :poi_info_id
      t.string :point_type
      t.string :addr
      t.string :zip
      t.string :zipmuni
      t.string :municipality
      t.string :public_access
      t.decimal :latitude
      t.decimal :longitude
      t.integer :commdist
      t.string :zone_name
      t.integer :zonemapno
      t.integer :dwmapno
      t.integer :nameid
      t.integer :pointsofinterest_id
      t.integer :fpd_uid
      t.string :web_poi
      t.string :web_street_addr
      t.string :web_muni_addr
      t.integer :parking_connection_id
      t.integer :parking_info_id
      t.integer :alt_nameid
      t.integer :alt2_nameid

      t.timestamps null: false
    end
  end
end
