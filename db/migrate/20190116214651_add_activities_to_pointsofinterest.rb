class AddActivitiesToPointsofinterest < ActiveRecord::Migration[5.1]
  def change
    add_column :pointsofinterests, :shower, :integer, default: 0
  	add_column :pointsofinterests, :dining_hall, :integer, default: 0
  	add_column :pointsofinterests, :sanitation_station, :integer, default: 0
  	add_column :pointsofinterests, :camp_store, :integer, default: 0
  	add_column :pointsofinterests, :no_dogs, :integer, default: 0
  end
end