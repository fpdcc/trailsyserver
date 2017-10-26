class MoveAlertFields < ActiveRecord::Migration
  def change
  	add_column :alerts, :starts_at, :datetime
  	add_column :alerts, :ends_at, :datetime
    add_column :alerts, :geom, :st_point, geographic: true
    remove_column :alertings, :starts_at
    remove_column :alertings, :ends_at
    remove_column :alertings, :geom
  end
end
