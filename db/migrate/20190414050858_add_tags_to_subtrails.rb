class AddTagsToSubtrails < ActiveRecord::Migration[5.1]
  def change
    add_column :trail_subtrails, :tags, :text
  end
end
