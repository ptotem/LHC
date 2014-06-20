class QuizAnswer < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :answer_id
end
