class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def mark_all_as_read
    current_user.notifications.unread.update_all(read_at: Time.current)
    redirect_back_or_to root_path
  end

  def read
    notification = current_user.notifications.find(params[:id])
    notification.mark_as_read!
    redirect_to notification.link.presence || root_path
  end
end
