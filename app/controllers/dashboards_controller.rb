class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_preconditons

  def show
    if current_user.founder?
      @startup = current_user.startup
      @listings = @startup.listings.active.order(created_at: :desc)
      @unread_messages = current_user.unread_messages.size
      @dashboard = "founder_dashboard"
    elsif current_user.investor?
      @listings = Listing.active.includes(:startup).order(created_at: :desc)
      @proposals = policy_scope(InvestmentProposal)
      @unread_messages = current_user.unread_messages.size
      @dashboard = "investor_dashboard"
    end
  end

  private

  def check_preconditons
    redirect_to new_startup_path if current_user.founder? and current_user.startup.blank?
    redirect_to new_investor_profile_path if current_user.investor? and current_user.investor_profile.blank?
  end
end
