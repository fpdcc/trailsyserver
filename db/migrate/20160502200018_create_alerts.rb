class CreateAlerts < ActiveRecord::Migration[4.2]
  def change
    create_table :alerts do |t|
      t.integer :alert_id
      t.integer :alert_type
      t.string :description
      t.string :link
      t.integer :created_by

      t.timestamps null: false
    end
  end
end
