class CreateExpectations < ActiveRecord::Migration
  def change
    create_table :expectations do |t|
      t.integer :user_id
      t.integer :question_id
      t.integer :rating_id

      t.timestamps
    end
  end
end
