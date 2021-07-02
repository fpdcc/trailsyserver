class AddWeblinkToTrailsDescs < ActiveRecord::Migration[5.1]
  def change
    add_column :trails_descs, :web_link, :string
  end
end
