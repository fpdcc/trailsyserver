class AddActivityAccessibleInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :pointsofinterests, :accessible_canoe, :boolean
    add_column :pointsofinterests, :accessible_fishing, :boolean
    add_column :pointsofinterests, :accessible_campsite, :boolean
    add_column :pointsofinterests, :accessible_boat, :boolean

    add_column :activities, :accessible, :boolean
  end
end
