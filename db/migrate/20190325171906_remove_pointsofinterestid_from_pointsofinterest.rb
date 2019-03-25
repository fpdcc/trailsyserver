class RemovePointsofinterestidFromPointsofinterest < ActiveRecord::Migration[5.1]
  def change
    remove_column :pointsofinterests, :pointsofinterest_id
  end
end
