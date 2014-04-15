class Quiz < ActiveRecord::Base
  belongs_to :test

  has_and_belongs_to_many :questions
end
