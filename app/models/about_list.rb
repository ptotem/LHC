class AboutList < ActiveRecord::Base

  #t.string :name

  has_and_belongs_to_many :users

end
