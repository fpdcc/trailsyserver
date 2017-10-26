class CreateTrailSubtrails < ActiveRecord::Migration
  def change
    create_table :trail_subtrails do |t|
      t.string :trail_subsystem, null: false
      t.string :trail_color
      t.string :trail_type
      t.string :segment_type
      t.string :direction
      t.string :off_fpdcc
      t.string :subtrail_id
      t.string :subtrail_name
      t.timestamps null: false      
    end
  end
end
