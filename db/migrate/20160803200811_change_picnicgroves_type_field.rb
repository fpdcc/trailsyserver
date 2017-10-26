class ChangePicnicgrovesTypeField < ActiveRecord::Migration[4.2]
  def change
  	rename_column :picnicgroves, :type, :picnicgrove_type
  end
end
