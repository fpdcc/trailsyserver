class AddOpenTrails11FieldsToTrails < ActiveRecord::Migration
  def change
  	add_column :trails, :segment_ids, :text, array: true, default: []
  	add_column :trails, :trail_id, :string
  	add_column :trails, :part_of, :text, array: true, default: []
  end
end
