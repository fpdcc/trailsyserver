class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :activities_id
      t.string :type
      t.string :name
      t.string :parking_entrance_id
      t.string :nameid

      t.timestamps
    end
  end
end
