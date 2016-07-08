class CreatePointsofinterests < ActiveRecord::Migration
  def change
    create_table :pointsofinterests do |t|
      t.integer :pointsofinterest_id
      t.st_point :geom, geographic: true

      t.timestamps null: false
    end
  end
end
