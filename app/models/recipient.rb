 class Recipient < ActiveRecord::Base

  belongs_to :user
  belongs_to :message
   belongs_to :sent_messages, class_name: 'User'
   #belongs_to :received_messages, class_name: 'User'
   belongs_to :receiver, class_name: 'Message'
   belongs_to :sender, class_name: 'Message'
end
