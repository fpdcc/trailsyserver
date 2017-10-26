class AddLogoToOrganization < ActiveRecord::Migration[4.2]
  def self.up
    add_attachment :organizations, :logo
  end

  def self.down
    remove_attachment :organizations, :logo
  end
end
