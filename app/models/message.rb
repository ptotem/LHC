class Message < ActiveRecord::Base

  has_many :recipients, :dependent => :destroy
  has_many :users, :through => :recipients
  belongs_to :user

end
