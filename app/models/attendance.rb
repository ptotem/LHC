class Attendance < ActiveRecord::Base

  #t.integer :user_id
  #t.integer :institution_id
  #t.date :year_from
  #t.date :year_to
  #t.string :office

  belongs_to :user
  belongs_to :institution


end
