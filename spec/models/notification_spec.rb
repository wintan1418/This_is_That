require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      notification = build(:notification)
      expect(notification).to be_valid
    end

    it 'is invalid with an unknown type' do
      notification = build(:notification, notification_type: 'unknown_type')
      expect(notification).not_to be_valid
    end
  end

  describe '.notify_match_saved' do
    it 'creates a match notification for the user' do
      user = create(:user)

      expect {
        Notification.notify_match_saved(user, "Blue Bottle")
      }.to change(Notification, :count).by(1)

      notification = Notification.last
      expect(notification.user).to eq(user)
      expect(notification.notification_type).to eq('match')
      expect(notification.title).to eq('Match Saved!')
    end
  end
end
