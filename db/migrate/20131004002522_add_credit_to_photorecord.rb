class AddCreditToPhotorecord < ActiveRecord::Migration[4.2]
  def change
    add_column :photorecords, :credit, :string
  end
end
