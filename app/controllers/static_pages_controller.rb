class StaticPagesController < ApplicationController
  before_action :redirect_dashboard, only: [ :landing ]
  def landing
  end
  def legal
  end
  def privacy
  end
  def about
  end
  def contact
  end
  def pricing
  end

  private

  def redirect_dashboard
    redirect_to dashboard_path if user_signed_in?
  end
end
