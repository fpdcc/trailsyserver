class ChangePicnicgroveType < ActiveRecord::Migration[4.2]
  def change
  	remove_column :picnicgroves, :picnicgrove_type
  	add_column :picnicgroves, :grove_type, :string
  end
end
