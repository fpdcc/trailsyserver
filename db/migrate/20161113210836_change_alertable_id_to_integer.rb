class ChangeAlertableIdToInteger < ActiveRecord::Migration
  def change
  	change_column :alertings, :alertable_id, 'integer USING CAST(alertable_id AS integer)'
  end
end
