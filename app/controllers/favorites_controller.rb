class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_favoritable_type, only: [ :create ]

  # Allowlist of favoritable models
  FAVORITABLE_TYPES = %w[Listing].freeze

  def index
    @favorites = current_user.favorites.includes(:favoritable)
  end

  def create
    @favoritable = @favoritable_class.find(params[:favoritable_id])
    @favorite = current_user.favorites.create(favoritable: @favoritable)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: root_path }
    end
  rescue ActiveRecord::RecordNotFound
    handle_invalid_favoritable
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @favoritable = @favorite.favoritable
    @favorite.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: dashboard_path }
    end
  end


  private

  def validate_favoritable_type
    # Sanitize and validate the class
    requested_type = params[:favoritable_type].to_s.classify
    return head :bad_request unless FAVORITABLE_TYPES.include?(requested_type)

    @favoritable_class = requested_type.safe_constantize
    head :bad_request if @favoritable_class.nil?
  end

  def handle_invalid_favoritable
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("alert", partial: "shared/alert") }
      format.html { redirect_back fallback_location: root_path, alert: "Invalid favorite request" }
    end
  end
end
