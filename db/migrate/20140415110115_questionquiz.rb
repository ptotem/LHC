class Questionquiz < ActiveRecord::Migration
  def change
    create_table :questions_quizzes do |t|
      t.integer :question_id
      t.integer :quiz_id
    end
  end
end
