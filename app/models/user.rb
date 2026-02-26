class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [ :facebook, :google_oauth2 ]

  # Associations
  has_many :places, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :search_histories, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # Validations
  validates :name, presence: true, length: { maximum: 100 }

  # OAuth helper methods
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.avatar = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session["devise.facebook_data"] || session["devise.google_data"])
        user.email = data["info"]["email"] if user.email.blank? && data["info"]
      end
    end
  end

  # Get user's home places
  def home_places
    places.where(is_home_place: true)
  end

  # Get matched places
  def matched_places
    places.where(is_home_place: false)
  end
end
