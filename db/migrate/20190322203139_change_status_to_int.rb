class ChangeStatusToInt < ActiveRecord::Migration[5.1]
  def change
    remove_column :updates, :status
    add_column :updates, :status, :integer
  end
end
