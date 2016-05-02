class CreateAlertings < ActiveRecord::Migration
  def change
    create_table :alertings do |t|
      t.string :alertable_type
      t.string :alertable_id
      t.integer :alert_id
      t.datetime :starts_at
      t.datetime :ends_at
      t.integer :created_by

      t.timestamps null: false
    end
  end
end
