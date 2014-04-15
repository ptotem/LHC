class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.integer :test_id
      t.string :name

      t.timestamps
    end
  end
end
