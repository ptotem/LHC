class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :authentications, :dependent => :destroy

  has_one :demographic, dependent: :destroy

  has_many :attendances, dependent: :destroy
  has_many :institutions, through: :attendances

  has_and_belongs_to_many :professions
  has_and_belongs_to_many :personalities
  has_and_belongs_to_many :movies
  has_and_belongs_to_many :songs
  has_and_belongs_to_many :books
  has_and_belongs_to_many :interests
  has_and_belongs_to_many :ice_breakers

  has_many :criterions, dependent: :destroy
  has_many :revelations, dependent: :destroy
  has_many :expectations, dependent: :destroy
  has_many :base_matches, dependent: :destroy
  has_many :mind_matches, dependent: :destroy
  has_many :total_matches, dependent: :destroy

  has_many :recipients, :dependent => :destroy
  has_many :messages, :through => :recipients

  accepts_nested_attributes_for :demographic
  accepts_nested_attributes_for :criterions
  accepts_nested_attributes_for :attendances

  def demographic
    super || build_demographic
  end

  def age
    now = Time.now.utc.to_date
    birthday = self.demographic.dob
    now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def find_matches
    if self.criterions.first.smoking == "Doesn't Matter" and self.criterions.first.drinking == "Doesn't Matter"
      reduced_users =  Demographic.where(:male=>self.criterions.first.male).map(&:user).map{|i| return i if (self.criterions.first.minage..self.criterions.first.maxage).include?(i.age)}
      return
    else
      if self.criterions.first.smoking == "Doesn't Matter"
       reduced_users =  Demographic.where(:male=>self.criterions.first.male, :drinking => self.criterions.first.drinking).map(&:user).map{|i| return i if (self.criterions.first.minage..self.criterions.first.maxage).include?(i.age)}
       return
      end
      if self.criterions.first.drinking == "Doesn't Matter"
        reduced_users =  Demographic.where(:male=>self.criterions.first.male, :smoking=> self.criterions.first.smoking).map(&:user).map{|i| return i if (self.criterions.first.minage..self.criterions.first.maxage).include?(i.age)}
        return
      end
      return reduced_users =  Demographic.where(:male=>self.criterions.first.male, :drinking => self.criterions.first.drinking, :smoking=> self.criterions.first.smoking).map(&:user).map{|i| return i if (self.criterions.first.minage..self.criterions.first.maxage).include?(i.age)}
    end
  end



  def self.find_for_linkedin_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0, 20], name: auth.info.name, location: auth.info.location, picture: auth.info.image, token: auth.credentials.token, secret: auth.credentials.secret, headline: auth.info.headline, industry: auth.info.industry, positions: auth.extra.raw_info.positions, educations: auth.extra.raw_info.educations)
      user.save
    end
    user
  end






end
