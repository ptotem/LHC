class Movie < ActiveRecord::Base

  #t.string :name
  #t.string :poster
  #t.text :description
  #t.date :release_date

  has_and_belongs_to_many :users

end
