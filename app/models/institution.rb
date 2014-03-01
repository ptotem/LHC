class Institution < ActiveRecord::Base

  has_many :attendances, dependent: :destroy
  has_many :users, through: :attendances

end
