class ChangeTypeInActivities < ActiveRecord::Migration[4.2]
  def change
  	rename_column :activities, :type, :activity_type
  end
end
