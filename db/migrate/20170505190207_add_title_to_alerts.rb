class AddTitleToAlerts < ActiveRecord::Migration
  def change
  	add_column :alerts, :title, :string
  end
end
