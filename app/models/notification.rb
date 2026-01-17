class Notification < ApplicationRecord
  belongs_to :user

  # Scopes
  scope :unread, -> { where(read: false) }
  scope :recent, -> { order(created_at: :desc).limit(10) }
  
  # Validations
  validates :title, presence: true
  validates :notification_type, inclusion: { in: %w[info success warning match review vote favorite] }
  
  # Mark as read
  def mark_as_read!
    update(read: true)
  end
  
  # Icon based on type
  def icon
    case notification_type
    when 'match' then '✨'
    when 'review' then '📝'
    when 'vote' then '👍'
    when 'favorite' then '⭐'
    when 'success' then '✅'
    when 'warning' then '⚠️'
    else '🔔'
    end
  end
  
  # Create notification helpers
  def self.notify_match_saved(user, place_name)
    create(
      user: user,
      title: "Match Saved!",
      message: "#{place_name} has been added to your matches.",
      notification_type: 'match',
      link: '/my_matches'
    )
  end
  
  def self.notify_new_review(user, place_name, reviewer_name)
    create(
      user: user,
      title: "New Review",
      message: "#{reviewer_name} reviewed #{place_name}.",
      notification_type: 'review'
    )
  end
  
  def self.notify_vote(user, review_id, vote_type)
    create(
      user: user,
      title: "Someone #{vote_type}d your review!",
      message: "Your review received a #{vote_type}.",
      notification_type: 'vote'
    )
  end
end
