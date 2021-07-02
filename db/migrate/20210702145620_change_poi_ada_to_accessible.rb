class ChangePoiAdaToAccessible < ActiveRecord::Migration[5.1]
  def change
    rename_column :pointsofinterests, :ada, :accessible
  end
end
