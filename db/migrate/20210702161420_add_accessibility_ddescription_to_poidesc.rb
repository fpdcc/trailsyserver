class AddAccessibilityDdescriptionToPoidesc < ActiveRecord::Migration[5.1]
  def change
    add_column :poi_descs, :accessibility_description, :string
  end
end
