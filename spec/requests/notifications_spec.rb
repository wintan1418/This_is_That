require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let(:user) { create(:user) }
  let!(:notification) { create(:notification, user: user, read: false) }

  before do
    sign_in user, scope: :user
  end

  describe "GET /notifications" do
    it "returns http success and shows notifications" do
      get notifications_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include(notification.title)
    end
  end

  describe "POST /notifications/mark_all_as_read" do
    it "marks all notifications as read" do
      expect(user.notifications.unread.count).to eq(1)

      post mark_all_as_read_notifications_path

      expect(response).to redirect_to(notifications_path)
      expect(user.notifications.unread.count).to eq(0)
    end
  end

  describe "POST /notifications/:id/mark_as_read" do
    it "marks a single notification as read" do
      post mark_as_read_notification_path(notification)

      expect(response).to redirect_to(notifications_path)
      expect(notification.reload.read).to be true
    end
  end
end
