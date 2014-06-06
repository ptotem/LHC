class AddColumnQuizTextToQuiz < ActiveRecord::Migration
  def change
    add_column :quizzes, :quiz_text, :string
  end
end
