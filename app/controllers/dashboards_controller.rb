class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    case current_user.role
    when "founder"
      redirect_to startup_path(current_user.startup)
    when "investor"
      @listings = Listing.active
      render "investor_dashboard"
    end
  end
end
