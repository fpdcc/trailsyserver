class CreatePoiDescs < ActiveRecord::Migration
  def change
    create_table :poi_descs do |t|
      t.integer :poi_info_id
      t.string :hours1
      t.string :hours2
      t.string :phone
      t.string :description
      t.string :web_link
      t.string :map_link
      t.string :map_link_spanish
      t.string :vol_link
      t.string :vol_link2
      t.string :picnic_link
      t.string :event_link
      t.string :custom_link
      t.string :season1
      t.string :season2
      t.string :special_hours
      t.string :special_description
      t.string :special_link
      t.string :photo_link
      t.integer :poi_desc_id

      t.timestamps null: false
    end
  end
end
