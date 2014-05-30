class Demographic < ActiveRecord::Base

  #t.integer :user_id
  #t.string :name
  #t.boolean :male
  #t.string :religion
  #t.date :dob
  #t.string :smoking
  #t.string :drinking
  #t.text :description
  #t.text :goal
  #t.integer :diffthresh
  has_attached_file :avatar,:default_url => "/assets/profile_pic.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  belongs_to :user


end
