class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :type # closure or alert using enum
      t.string  :reason # reason for closure
      t.string  :title
      t.string  :description
      t.date    :start_date
      t.date    :end_date
      t.string  :statusable_type
      t.string  :statusable_id
      t.integer :created_by
      t.timestamps null: false
    end
  end
end
