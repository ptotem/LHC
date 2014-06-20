class Criterion < ActiveRecord::Base

  #t.integer :user_id
  #t.boolean :male
  #t.integer :minage
  #t.integer :maxage
  #t.string :smoking
  #t.string :drinking

  belongs_to :user
  #validates_numericality_of :minage
  #validates_numericality_of :maxage, :greater_than => :minage,:message => "The minimum age cannot be greater than maximum age"

  #validates_presence_of :male
  #validates_inclusion_of :male, :in => [true, false]

end
