class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :demographic, dependent: :destroy

  has_many :attendances, dependent: :destroy
  has_many :institutions, through: :attendances

  has_and_belongs_to_many :professions
  has_and_belongs_to_many :personalities
  has_and_belongs_to_many :movies
  has_and_belongs_to_many :songs
  has_and_belongs_to_many :books
  has_and_belongs_to_many :interests

  has_many :criterions, dependent: :destroy
  has_many :revelations, dependent: :destroy
  has_many :expectations, dependent: :destroy
  has_many :base_matches, dependent: :destroy
  has_many :mind_matches, dependent: :destroy
  has_many :total_matches, dependent: :destroy

end
