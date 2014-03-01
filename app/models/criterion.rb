class Criterion < ActiveRecord::Base

  #t.integer :user_id
  #t.boolean :male
  #t.integer :minage
  #t.integer :maxage
  #t.string :smoking
  #t.string :drinking

  belongs_to :user

end
