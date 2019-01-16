class AddStatusToUpdates < ActiveRecord::Migration[5.1]
  def change
    add_column :updates, :status, :string
  	add_column :updates, :job, :string
  end
end
