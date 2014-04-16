class Notification < ActiveRecord::Base

  #t.string   "content"
  #t.integer  "user_id"
  #t.string   "pointer_link"

  belongs_to :user

end
