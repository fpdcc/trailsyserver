class AddMaintenanceNicknameToPointsofinterest < ActiveRecord::Migration
  def change
  	add_column :pointsofinterests, :maintenance_div_nickname, :string
  end
end
