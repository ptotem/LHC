class QuizCategory < ActiveRecord::Base

  has_attached_file :avatar
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :quizzes,:dependent => :destroy
end
