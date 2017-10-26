class AddReasonToAlerts < ActiveRecord::Migration
  def change
  	add_column :alerts, :reason, :string
  end
end
