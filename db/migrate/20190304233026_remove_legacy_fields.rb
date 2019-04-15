class RemoveLegacyFields < ActiveRecord::Migration[5.1]
  def change
    remove_column :activities, :nameid
    remove_column :parking_entrances, :nameid
    remove_column :parking_entrances, :parking_entrance_id
  end
end
