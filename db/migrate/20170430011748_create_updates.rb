class CreateUpdates < ActiveRecord::Migration[4.2]
  def change
    create_table :updates do |t|
      t.string :filename
      t.text :updatedata
      t.timestamps null: false
    end
  end
end
