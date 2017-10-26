class ChangeTypeToStatusType < ActiveRecord::Migration[4.2]
  def change
  	rename_column :statuses, :type, :status_type
  end
end
