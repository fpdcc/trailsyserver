class AddFieldsToPoiAmenities < ActiveRecord::Migration
  def change
  	add_column    :poi_amenities, :nature_preserve, :integer
  	add_column    :poi_amenities, :no_fishing, :integer
  	add_column    :poi_amenities, :public_building, :integer
  	add_column    :poi_amenities, :driving_range, :integer
  end
end
