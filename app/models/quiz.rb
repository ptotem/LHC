class Quiz < ActiveRecord::Base
  belongs_to :quiz_category
  has_and_belongs_to_many :questions
end
