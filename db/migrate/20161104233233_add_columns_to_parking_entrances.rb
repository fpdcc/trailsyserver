class AddColumnsToParkingEntrances < ActiveRecord::Migration
  def change
    add_column :parking_entrances, :nameid, :integer
    add_column :parking_entrances, :entrance_closed, :string
  end
end
