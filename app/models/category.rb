class Category < ApplicationRecord
  # Associations
  has_many :places, dependent: :nullify

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :yelp_alias, presence: true, uniqueness: true

  # Scopes
  scope :alphabetical, -> { order(:name) }

  def to_s
    name
  end
end
