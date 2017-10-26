class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.string :filename
      t.text :updatedata
      t.timestamps null: false
    end
  end
end
