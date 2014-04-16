class IceBreaker < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :questions
  #accepts_nested_attributes_for :questions

end
