class AddColumnsToParkingEntrances < ActiveRecord::Migration[4.2]
  def change
    add_column :parking_entrances, :nameid, :integer
    add_column :parking_entrances, :entrance_closed, :string
  end
end
