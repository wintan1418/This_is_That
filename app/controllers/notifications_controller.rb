class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.recent
  end

  def mark_as_read
    @notification = current_user.notifications.find(params[:id])
    @notification.mark_as_read!

    respond_to do |format|
      format.html { redirect_to @notification.link || notifications_path }
      format.turbo_stream { head :ok }
    end
  end

  def mark_all_as_read
    current_user.notifications.unread.update_all(read: true)

    respond_to do |format|
      format.html { redirect_to notifications_path, notice: "All notifications marked as read." }
      format.turbo_stream { head :ok }
    end
  end
end
