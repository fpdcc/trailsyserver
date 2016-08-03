class ChangePicnicgrovesTypeField < ActiveRecord::Migration
  def change
  	rename_column :picnicgroves, :type, :picnicgrove_type
  end
end
