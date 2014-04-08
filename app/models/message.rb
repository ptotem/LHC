class Message < ActiveRecord::Base

  #has_many :recipients, :dependent => :destroy
  #has_many :users, :through => :recipients
  #belongs_to :user
  has_one :sent_messages, class_name: 'Recipient', foreign_key: 'message_id'
  has_one :sender, through: :sent_messages, foreign_key: 'sender_id', class_name: 'User'

  has_many :received_messages, class_name: 'Recipient', foreign_key: 'message_id'
  has_many :receivers, through: :received_messages, foreign_key: 'receiver_id', class_name: 'User'
end
