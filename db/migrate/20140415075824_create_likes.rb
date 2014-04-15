class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.boolean :status,:default => false

      t.timestamps
    end
  end
end
