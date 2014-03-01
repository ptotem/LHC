class RatingScale < ActiveRecord::Base

  has_many :ratings, dependent: :destroy
  has_many :questions, dependent: :destroy

end
