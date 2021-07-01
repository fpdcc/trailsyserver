class AddPicnicgrovesAccessibleFields < ActiveRecord::Migration[5.1]
  def change
    add_column :picnicgroves, :accessible, :boolean
    add_column :picnicgroves, :parking_to_shelter, :decimal
    add_column :picnicgroves, :shelter_to_bathroom, :decimal
    add_column :picnicgroves, :bathroom_type, :string

    add_column :pointsofinterests, :accessible_shelter, :boolean
  end
end
