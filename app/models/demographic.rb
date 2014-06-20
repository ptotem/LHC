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
  has_attached_file :avatar,
                    :default_url => "/assets/profile_pic.jpg",
                    :styles     => { :medium => "300x300>", :thumb => "100x100>" },
                    :convert_options => {
                        :medium => "-quality 80 -interlace Plane",
                        :thumb => "-quality 80 -interlace Plane"
                    },
                    :processors => [:thumbnail, :compression]

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  belongs_to :user

  validates_presence_of :nickname,:last_institute
  validates_inclusion_of :male, :in => [true, false]

end
