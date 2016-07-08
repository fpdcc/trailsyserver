class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.integer :nameid
      t.string :name
      t.integer :old_id

      t.timestamps null: false
    end
  end
end
