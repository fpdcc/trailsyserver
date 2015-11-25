class AddOpenTrails11FieldsToTrailsegments < ActiveRecord::Migration
  def change
  	add_column :trailsegments, :segment_id, :string
  	add_column :trailsegments, :foot, :string
  	add_column :trailsegments, :bicycle, :string
  	add_column :trailsegments, :horse, :string
  	add_column :trailsegments, :ski, :string
  	add_column :trailsegments, :wheelchair, :string
  	add_column :trailsegments, :motor_vehicles, :string

  end
end
