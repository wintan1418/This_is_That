class Place < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :category, optional: true
  has_many :reviews, dependent: :destroy

  # Image attachment (Active Storage)
  has_one_attached :image

  # Geocoding
  # Geocoding - safely handle API errors
  geocoded_by :full_address
  after_validation :safe_geocode, if: ->(obj) { obj.address_changed? && obj.latitude.blank? }

  def safe_geocode
    geocode
  rescue => e
    Rails.logger.error "Geocoding error: #{e.message}"
    # Don't fail the save if geocoding fails
  end

  # Validations
  validates :name, presence: true
  validates :address, presence: true, if: :is_home_place
  validates :city, presence: true, if: :is_home_place

  # Scopes
  scope :home_places, -> { where(is_home_place: true) }
  scope :matched_places, -> { where(is_home_place: false) }
  scope :by_category, ->(category) { where(category: category) }
  scope :in_city, ->(city) { where("LOWER(city) = ?", city.downcase) }
  scope :favorites, -> { where(is_favorite: true) }
  scope :public_places, -> { order(created_at: :desc).limit(20) }

  # Full address for geocoding
  def full_address
    [address, city, state, country].map(&:presence).compact.join(", ")
  end

  # Average rating from reviews
  def average_rating
    reviews.average(:rating)&.round(1) || rating || 0
  end

  # Display price as symbols
  def price_display
    price || "N/A"
  end
end
