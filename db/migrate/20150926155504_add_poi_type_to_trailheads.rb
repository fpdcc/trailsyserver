class AddPoiTypeToTrailheads < ActiveRecord::Migration
  def change
    add_column :trailheads, :poi_type, :string
  end
end
