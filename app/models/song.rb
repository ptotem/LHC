class Song < ActiveRecord::Base

  #t.string :name
  #t.string :album
  #t.string :band
  #t.text :lyrics
  #t.date :release_date

  has_and_belongs_to_many :users

end
