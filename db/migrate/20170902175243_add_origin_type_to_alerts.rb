class AddOriginTypeToAlerts < ActiveRecord::Migration[5.1]
  def change
  	add_column :alerts, :origin_type, :integer
  end
end
