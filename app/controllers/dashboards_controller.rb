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
      @proposals = policy_scope(InvestmentProposal)
      @unread_messages = current_user.unread_messages.size
      @dashboard = "investor_dashboard"
    end
  end
end
