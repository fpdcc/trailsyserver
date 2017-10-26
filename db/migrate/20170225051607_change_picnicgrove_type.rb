class ChangePicnicgroveType < ActiveRecord::Migration
  def change
  	remove_column :picnicgroves, :picnicgrove_type
  	add_column :picnicgroves, :grove_type, :string
  end
end
