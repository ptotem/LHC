class Book < ActiveRecord::Base

  #t.string :name
  #t.string :cover
  #t.string :author
  #t.text :synopsis
  #t.date :release_date

  has_and_belongs_to_many :users

end
