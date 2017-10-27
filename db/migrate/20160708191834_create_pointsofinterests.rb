class CreatePointsofinterests < ActiveRecord::Migration[4.2]
  def change
    create_table :pointsofinterests do |t|
      t.integer :pointsofinterest_id
      t.st_point :geom, geographic: true

      t.timestamps null: false
    end
  end
end
