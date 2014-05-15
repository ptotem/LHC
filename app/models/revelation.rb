class Revelation < ActiveRecord::Base

  #t.integer :user_id
  #t.integer :question_id
  #t.integer :rating_id

  belongs_to :user
  belongs_to :question
  belongs_to :rating

end
