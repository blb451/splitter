class User < ApplicationRecord

  acts_as_messageable

  has_many :music_choices, dependent: :destroy
  has_many :followings, dependent: :destroy
  has_many :followers, through: :followings
  has_many :stalkings, foreign_key: :follower_id, class_name: 'Following'
  has_many :followed_users, through: :stalkings, source: :user
  has_many :comments, dependent: :nullify
  has_many :suggestions, dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :newsfeeds, dependent: :destroy
  has_many :stashed_musics, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :omniauthable, :omniauth_providers => [:spotify]

  validates :username, uniqueness: {case_sensitive: false }, length: { minimum: 3, maximum: 10 }

  mount_uploader :image, ImageUploader

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.skip_confirmation!
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.image = auth.info.image
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.search(search)
    if search
      self.where('username ILIKE ? OR first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?',
       "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    else
      self.all
    end
  end

  def mailboxer_name
    self.name
  end

  def mailboxer_email(object)
    self.email
  end

end
