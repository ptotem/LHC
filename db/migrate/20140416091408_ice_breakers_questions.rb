class IceBreakersQuestions < ActiveRecord::Migration
  def change
    create_table :ice_breakers_questions do |t|
      t.integer :ice_breaker_id
      t.integer :question_id
    end
  end
end
