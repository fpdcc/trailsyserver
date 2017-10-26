class AddPoiTypeToTrailheads < ActiveRecord::Migration[4.2]
  def change
    add_column :trailheads, :poi_type, :string
  end
end
