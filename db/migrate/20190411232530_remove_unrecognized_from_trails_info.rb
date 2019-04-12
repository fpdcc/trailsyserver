class RemoveUnrecognizedFromTrailsInfo < ActiveRecord::Migration[5.1]
  def change
    remove_column :trails_infos, :unrecognized, :string
  end
end
