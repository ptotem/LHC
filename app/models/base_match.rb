class BaseMatch < ActiveRecord::Base

  #t.integer :user_id
  #t.integer :target_id
  #t.boolean :gender_fit
  #t.boolean :age_fit
  #t.boolean :smoking_fit
  #t.boolean :drinking_fit

  belongs_to :user

end
