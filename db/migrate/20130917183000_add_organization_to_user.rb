class AddOrganizationToUser < ActiveRecord::Migration[4.2]
  def self.up
    add_column :users, :organization, :string
  end

  def self.down
    remove_column :users, :organization
  end
end
