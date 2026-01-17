class Review < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :place
  has_many :votes, dependent: :destroy

  # Validations
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :content, length: { maximum: 1000 }
  validates :user_id, uniqueness: { scope: :place_id, message: "can only review a place once" }

  # Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :by_rating, ->(rating) { where(rating: rating) }

  # Rating display helper
  def rating_stars
    "★" * rating + "☆" * (5 - rating)
  end

  # Vote counts
  def upvotes_count
    votes.where(value: 1).count
  end

  def downvotes_count
    votes.where(value: -1).count
  end

  def vote_score
    upvotes_count - downvotes_count
  end

  # Check if user has voted
  def voted_by?(user)
    return nil unless user
    votes.find_by(user: user)&.value
  end
end
