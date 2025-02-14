class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: [ :show ]

  def index
    @notifications = current_user.notifications.unread
  end

  def show
  end

  def mark_all_as_read
    Mailboxer::Notification.mark_as_read(current_user)
    flash[:success] = "All notifications have been marked as read."
    redirect_to notifications_path
  end

  private

  def set_notification
    @notification = current_user.notifications.find(params[:id])
  end

  def notification_params
    params.require(:notification).permit(:subject, :body)
  end
end
