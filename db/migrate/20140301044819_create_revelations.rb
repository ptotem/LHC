class CreateRevelations < ActiveRecord::Migration
  def change
    create_table :revelations do |t|
      t.integer :user_id
      t.integer :question_id
      t.integer :rating_id

      t.timestamps
    end
  end
end
