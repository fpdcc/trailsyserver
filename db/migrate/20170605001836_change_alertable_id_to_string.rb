class ChangeAlertableIdToString < ActiveRecord::Migration[4.2]
  def change
  	change_column :alertings, :alertable_id, :string
  end
end
