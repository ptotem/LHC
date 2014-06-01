class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  #validates :confirmation_token, :uniqueness => true, :allow_blank => true

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
  has_many :rejected_matches, dependent: :destroy
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
    # self.last_matched_time = Time.now
    # self.save!
  end

  def update_match_status


    # TODO: uncomment this to start matching...
    # BaseMatch.where(:user_id => self.id).each do |m|
    #   # m.match_status = false
    #   # m.save!
    # end
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
      rejected_array = Array.new
      self.rejected_matches.each do |u|
        rejected_array << User.find(u.rejected_target)
      end
      reduced_users = (reduced_users-User.where(:id => BaseMatch.where(:user_id => self.id,:match_status => true).map(&:target_id)))
      reduced_users = (reduced_users-rejected_array).compact

      #return reduced_users
    end

    # TODO: uncomment this to start matching...
    # count = 0
    # tmp = Array.new
    # puts "reduced_users #{reduced_users}"
    # puts "rejected matches #{self.rejected_matches}"
    # x = (reduced_users.shuffle[0..2]).compact
    #
    # #reduced_users [nil, #<User id: 192, email: "ashwin@abc2.com", encrypted_password: "$2a$10$5dh2MLm34RlIOLBJoy52DO514PuNeb010HWDWs96yilj...", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2014-05-27 05:21:57", last_sign_in_at: "2014-05-27 05:21:57", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", created_at: "2014-05-22 08:14:23", updated_at: "2014-05-27 05:22:24", uid: nil, is_admin: false, confirmation_token: "fba58bd8437052c9988b6198d3565e9824f13c78b61e8098b26...", confirmed_at: "2014-05-22 08:41:54", confirmation_sent_at: "2014-05-22 08:14:23", verification_text: nil, verified: nil, current_route: "/my_dashboard", last_matched_time: nil, first_visit: false, provider: nil>, nil, nil, #<User id: 231, email: "ali@abc41.com", encrypted_password: "$2a$10$RlwkULQ.zA45a8a.zAN4o.P7aUAaGLYfG7y7MS5M1rMW...", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, created_at: "2014-05-22 08:17:32", updated_at: "2014-05-22 08:41:54", uid: nil, is_admin: false, confirmation_token: "93356b14d9254a16646c9903c0e410a997e32689a0328147e29...", confirmed_at: "2014-05-22 08:41:54", confirmation_sent_at: "2014-05-22 08:17:32", verification_text: nil, verified: nil, current_route: "/fill_dates", last_matched_time: nil, first_visit: false, provider: nil>, nil, #<User id: 259, email: "avaid@abc69.com", encrypted_password: "$2a$10$2NAd/F135lKcTYTlPQnix.OQecjxG4BGnHRzuyQZUjrR...", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, created_at: "2014-05-22 08:19:42", updated_at: "2014-05-22 08:41:54", uid: nil, is_admin: false, confirmation_token: "bc4e58b2bfc65be2c30497838a76b81c0991df793bad7e0b509...", confirmed_at: "2014-05-22 08:41:54", confirmation_sent_at: "2014-05-22 08:19:42", verification_text: nil, verified: nil, current_route: "/fill_dates", last_matched_time: nil, first_visit: false, provider: nil>, nil, nil, nil, #<User id: 285, email: "mohammed@abc95.com", encrypted_password: "$2a$10$nHtXnrm1F1nOdwD8QePuHu2XEYckfyZoQP0HFArlYbEy...", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, created_at: "2014-05-22 08:21:41", updated_at: "2014-05-22 08:41:54", uid: nil, is_admin: false, confirmation_token: "b0fc5f10125368b655aabd78d4220291f47afe7774b34960e8a...", confirmed_at: "2014-05-22 08:41:54", confirmation_sent_at: "2014-05-22 08:21:41", verification_text: nil, verified: nil, current_route: "/fill_dates", last_matched_time: nil, first_visit: false, provider: nil>, #<User id: 293, email: "sunny@abc103.com", encrypted_password: "$2a$10$F8DdNFnNjprkTJBFjJQFs.xLpd2x2aPwJqQN9kYYpbzy...", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, created_at: "2014-05-22 08:22:21", updated_at: "2014-05-22 08:41:55", uid: nil, is_admin: false, confirmation_token: "fc8f938a32e939a616f25ee68b4ff93440620c6e44125f167b2...", confirmed_at: "2014-05-22 08:41:55", confirmation_sent_at: "2014-05-22 08:22:21", verification_text: nil, verified: nil, current_route: "/fill_dates", last_matched_time: nil, first_visit: false, provider: nil>, nil, nil, nil, nil, #<User id: 323, email: "ashwin@abc133.com", encrypted_password: "$2a$10$BXkozHnrSU7MsAgcdOUa0eXLiJrVjYZemgcNh1GnL1ez...", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, created_at: "2014-05-22 08:24:35", updated_at: "2014-05-22 08:41:55", uid: nil, is_admin: false, confirmation_token: "b9d0437a0c483346215d4cfd04666422394b4cbb4a0d028b913...", confirmed_at: "2014-05-22 08:41:55", confirmation_sent_at: "2014-05-22 08:24:35", verification_text: nil, verified: nil, current_route: "/fill_dates", last_matched_time: nil, first_visit: false, provider: nil>, nil, nil, nil, #<User id: 358, email: "divjot@abc168.com", encrypted_password: "$2a$10$t2rWYwOAo.1ciTnvHVPSueQbPesvkPA7WYqKBjRoZ0vj...", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2014-05-27 12:30:09", last_sign_in_at: "2014-05-27 12:30:09", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", created_at: "2014-05-22 08:27:22", updated_at: "2014-05-27 12:30:56", uid: nil, is_admin: false, confirmation_token: "f4a6a33c5ac44c8a8fb79e43540df8647fbfc1d6810b834b31d...", confirmed_at: "2014-05-22 08:41:55", confirmation_sent_at: "2014-05-22 08:27:22", verification_text: nil, verified: nil, current_route: "/my_dashboard", last_matched_time: nil, first_visit: false, provider: nil>, nil]
    # x.each_with_index do |b,index|
    #       BaseMatch.create!(:user_id=>self.id, :target_id=>b.id, :match_status=> true)
    #       tmp << b.id
    # end
    # Notification.create!(:content=>"You have got 3 new matches, check them out!", :user_id=>self.id, :pointer_link=>"/quick_matches",:notification_seen=>false)
    # if x.length >0
    #   QuickMatchMailer.quick_match_email(x.map(&:id), self.id).deliver
    # end
    # return tmp

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



  after_create :domain_name_checking


  def domain_name_checking
    extracted_email=self.email.split("@").last
    domain_array=DomainName.all.map(&:name)
    if domain_array.any?{|s| s.include?(extracted_email)}
      self.verified=true
      self.save!
    end
  end

end
