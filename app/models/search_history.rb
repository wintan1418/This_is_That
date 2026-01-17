class SearchHistory < ApplicationRecord
  belongs_to :user

  validates :home_city, presence: true
  validates :new_city, presence: true

  scope :recent, -> { order(created_at: :desc) }

  def display_text
    text = "#{home_city} → #{new_city}"
    text += " (#{category})" if category.present?
    text
  end
end
