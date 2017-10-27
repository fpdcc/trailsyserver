class CreateOrganizations < ActiveRecord::Migration[4.2]
  def change
    create_table :organizations do |t|
      t.string :code
      t.string :full_name
      t.string :phone
      t.string :url

      t.timestamps
    end
  end
end
