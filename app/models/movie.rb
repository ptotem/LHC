class Movie < ActiveRecord::Base

  #t.string :name
  #t.string :poster
  #t.text :description
  #t.date :release_date

  has_attached_file :movie_poster
  validates_attachment_content_type :movie_poster, :content_type => /\Aimage\/.*\Z/
  has_and_belongs_to_many :users

end
