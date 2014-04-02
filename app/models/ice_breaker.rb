class IceBreaker < ActiveRecord::Base

  has_and_belongs_to_many :users
  has_many :quests, dependent: :destroy

end
