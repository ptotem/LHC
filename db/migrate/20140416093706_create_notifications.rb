class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :content
      t.integer :user_id
      t.string :pointer_link

      t.timestamps
    end
  end
end
