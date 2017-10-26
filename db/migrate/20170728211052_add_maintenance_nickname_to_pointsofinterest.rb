class AddMaintenanceNicknameToPointsofinterest < ActiveRecord::Migration[4.2]
  def change
  	add_column :pointsofinterests, :maintenance_div_nickname, :string
  end
end
