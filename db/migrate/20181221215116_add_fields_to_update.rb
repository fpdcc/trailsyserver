class AddFieldsToUpdate < ActiveRecord::Migration[5.1]
  def change
    add_column :updates, :created_by, :integer
    add_column :updates, :approved_by, :integer
    add_column :updates, :approved, :boolean, default: false
    add_column :updates, :run_at, :datetime
  end
end
