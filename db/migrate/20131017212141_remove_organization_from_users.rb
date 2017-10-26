class RemoveOrganizationFromUsers < ActiveRecord::Migration[4.2]
  def change
    remove_column :users, :organization
  end
end
