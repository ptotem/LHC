class Quiz < ActiveRecord::Base
  belongs_to :test
  has_many :quests,:foreign_key => :quiz_id,:dependent=>:destroy
end
