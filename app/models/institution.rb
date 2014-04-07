class Institution < ActiveRecord::Base

  #t.string   "name"

  has_many :attendances, dependent: :destroy
  has_many :users, through: :attendances

end
