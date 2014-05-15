class MindMatch < ActiveRecord::Base

  #t.integer :user_id
  #t.integer :target_id
  #t.integer :question_id
  #t.integer :valuediff
  #t.boolean :mind_fit

  belongs_to :user
  belongs_to :question

end
