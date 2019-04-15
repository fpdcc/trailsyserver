# This migration and AddTransactionIdColumnToVersions provide the necessary
# schema for tracking associations.
class AddForeignTypeToVersionAssociations < ActiveRecord::Migration[5.1]
  def self.up
    add_column :version_associations, :foreign_type, :string, index: true
  end

  def self.down
    remove_column :version_associations, :foreign_type
  end
end
