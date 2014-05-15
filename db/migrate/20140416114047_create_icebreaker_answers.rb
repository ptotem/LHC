class CreateIcebreakerAnswers < ActiveRecord::Migration
  def change
    create_table :icebreaker_answers do |t|
      t.integer :ice_breaker_id
      t.integer :question_id
      t.integer :user_id
      t.integer :answer_id

      t.timestamps
    end
  end
end
