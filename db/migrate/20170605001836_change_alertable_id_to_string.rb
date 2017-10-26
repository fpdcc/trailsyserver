class ChangeAlertableIdToString < ActiveRecord::Migration
  def change
  	change_column :alertings, :alertable_id, :string
  end
end
