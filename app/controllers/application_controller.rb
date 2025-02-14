class ApplicationController < ActionController::Base
  include Pundit::Authorization
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_profile_completion

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::RoutingError, with: :render_not_found
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def switch_user_to(user)
    terminate_session if authenticated?
    start_new_session_for user
    pundit_reset!
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :role ])
  end

  def check_profile_completion
    return unless devise_controller?
    return unless user_signed_in?

    case current_user.role.to_sym
    when :founder
      redirect_to new_startup_path unless current_user.startup
    when :investor
      redirect_to new_investor_profile_path unless current_user.investor_profile
    end
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_dashboard_path  # Active Admin dashboard
    else
      dashboard_path  # App dashboard for regular users
    end
  end

  def render_not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end

  def not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back_or_to(dashboard_path)
  end
end
