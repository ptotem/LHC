class Message < ActiveRecord::Base

  #has_many :recipients, :dependent => :destroy
  #has_many :users, :through => :recipients
  #belongs_to :user
  #has_one :sender_recipients, class_name: 'Recipient', foreign_key: 'message_id'
  #has_one :sender, through: :sender_recipients, foreign_key: 'sender_id', class_name: 'User'

  #has_many :receiver_recipients, class_name: 'Recipient', foreign_key: 'message_id'
  #has_many :receivers, through: :receiver_recipients, foreign_key: 'receiver_id', class_name: 'User'

  belongs_to :user

end
