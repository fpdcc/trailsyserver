class AddMetadataToVersions < ActiveRecord::Migration[5.1]
  def change
  	add_column :versions, :full_desc, :string
  	add_column :versions, :pois, :string
  	add_column :versions, :trails, :string
  end
end
