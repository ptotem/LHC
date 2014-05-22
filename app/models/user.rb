class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :authentications, :dependent => :destroy

  has_one :demographic, dependent: :destroy
  has_one :criterion, dependent: :destroy

  has_many :attendances, dependent: :destroy
  has_many :institutions, through: :attendances

  has_many :quiz_answers, dependent: :destroy

  has_one :profession, dependent: :destroy

  has_and_belongs_to_many :personalities
  has_and_belongs_to_many :movies
  has_and_belongs_to_many :songs
  has_and_belongs_to_many :books
  has_and_belongs_to_many :interests






  has_and_belongs_to_many :hobby_lists
  has_and_belongs_to_many :about_lists

  has_many :revelations, dependent: :destroy
  has_many :expectations, dependent: :destroy
  has_many :base_matches, dependent: :destroy
  has_many :mind_matches, dependent: :destroy
  has_many :total_matches, dependent: :destroy
  has_many :user_documents, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_many :recipients, foreign_key: 'sender_id', :dependent => :destroy
  has_many :messages, :through => :recipients, foreign_key: 'sender_id'

  #has_many :reverse_recipients, class_name: 'Recipient', foreign_key: 'receiver_id'
  #has_many :received_messages, through: :reverse_recipients, foreign_key: 'receiver_id', class_name: 'Message', source: :message

  has_many :sent_icebreakers ,:class_name=>"IceBreaker",:foreign_key=>:sender_id
  has_many :received_icebreakers ,:class_name=>"IceBreaker",:foreign_key=>:receiver_id

  has_many :sent_likes ,:class_name=>"Like",:foreign_key=>:sender_id
  has_many :received_likes ,:class_name=>"Like",:foreign_key=>:receiver_id

  has_many :sent_messages ,:class_name=>"Message",:foreign_key=>:sender_id
  has_many :received_messages ,:class_name=>"Message",:foreign_key=>:receiver_id




  accepts_nested_attributes_for :demographic
  accepts_nested_attributes_for :criterion
  accepts_nested_attributes_for :profession
  accepts_nested_attributes_for :attendances
  accepts_nested_attributes_for :notifications
  accepts_nested_attributes_for :hobby_lists

  def demographic
    super || build_demographic
  end

  def criterion
    super || build_criterion
  end

  def attendances
    super || build_attendances
  end

  def profession
    super || build_profession
  end

  def age
    now = Time.now.utc.to_date
    birthday = self.demographic.dob
    now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def update_match
    self.last_matched_time = Time.now
    self.save!
  end

  def update_match_status

    BaseMatch.where(:user_id => self.id).each do |m|
      m.match_status = false
      m.save!
    end
  end


  def find_matches
    #Don't Care, Doesn't Matter
    reduced_users = []
    if self.criterion.smoking == "Don't Care" and self.criterion.drinking == "Don't Care"
      puts "if criterion both don't care"
      reduced_users =  Demographic.where(:male=>self.criterion.male).map(&:user).map{|i| i if (self.criterion.minage..self.criterion.maxage).include?(i.age)}

    else
      if self.criterion.smoking == "Don't Care"
        puts "if criterion smoking dont'care"
        reduced_users =  Demographic.where(:male=>self.criterion.male, :drinking => self.criterion.drinking).map(&:user).map{|i| i if (self.criterion.minage..self.criterion.maxage).include?(i.age)}
        #return reduced_users
      end
      if self.criterion.drinking == "Don't Care"
        puts "if criterion drinking dont'care"
        reduced_users =  Demographic.where(:male=>self.criterion.male, :smoking=> self.criterion.smoking).map(&:user).map{|i| i if (self.criterion.minage..self.criterion.maxage).include?(i.age)}
        #return reduced_users
      end
      if reduced_users == []
      reduced_users =  Demographic.where(:male=>self.criterion.male, :drinking => self.criterion.drinking, :smoking=> self.criterion.smoking).map(&:user).map{|i| i if (self.criterion.minage..self.criterion.maxage).include?(i.age)}
      end
      #return reduced_users
      reduced_users = (reduced_users-User.where(:id => BaseMatch.where(:user_id => self.id,:match_status => true).map(&:target_id)))

      #return reduced_users
    end

    count = 0
    tmp = Array.new
    reduced_users.shuffle.each_with_index do |b,index|
      if !b.nil? and count < 3
        BaseMatch.create!(:user_id=>self.id, :target_id=>b.id, :match_status=> true)
        tmp << b.id
        count = count+1
      end
    end
    return tmp

  end



  def self.find_for_linkedin_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0, 20], name: auth.info.name, location: auth.info.location, picture: auth.info.image, token: auth.credentials.token, secret: auth.credentials.secret, headline: auth.info.headline, industry: auth.info.industry, positions: auth.extra.raw_info.positions, educations: auth.extra.raw_info.educations)
      user.save
    end
    user
  end



  #before_create :set_standard_password
  ##before_save :set_standard_password
  #before_validation :set_standard_password

  def set_standard_password
    self.password="password"
    self.password_confirmation="password"
    true
  end


end
