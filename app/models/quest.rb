class Quest < ActiveRecord::Base

  #t.string :name

  belongs_to :ice_breaker
  has_many :options, dependent: :destroy
  has_one :answer, dependent: :destroy
  belongs_to :quiz

end
