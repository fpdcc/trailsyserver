class AddMoreDetailsToTrailheads < ActiveRecord::Migration[4.2]
  def change
    add_column :trailheads, :season1, :string
    add_column :trailheads, :season2, :string
    add_column :trailheads, :special_hours, :string
    add_column :trailheads, :special_description, :string
    add_column :trailheads, :special_link, :string
    add_column :trailheads, :photo_link, :string
  end
end
