class QuizCategory < ActiveRecord::Base
  has_many :quizzes,:dependent => :destroy
end
