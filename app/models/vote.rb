class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :review

  # Value: 1 = upvote, -1 = downvote
  validates :value, presence: true, inclusion: { in: [ -1, 1 ] }
  validates :user_id, uniqueness: { scope: :review_id, message: "has already voted on this review" }
end
