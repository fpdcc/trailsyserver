class AddReasonToAlerts < ActiveRecord::Migration[4.2]
  def change
  	add_column :alerts, :reason, :string
  end
end
