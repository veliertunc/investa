class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    case current_user.role.to_sym
    when :founder
      @startup = current_user.startup
      @listings = @startup.listings.active.order(created_at: :desc)
      @unread_messages = current_user.unread_messages.size
      @dashboard = "founder_dashboard"
    when :investor
      @listings = Listing.active.includes(:startup).order(created_at: :desc)
      @proposals = current_user.investor_profile.investment_proposals.includes(:listing)
      @unread_notifications = current_user.notifications.unread.size
      @dashboard = "investor_dashboard"
    end
  end
end
