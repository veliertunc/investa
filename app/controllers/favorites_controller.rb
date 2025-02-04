class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = current_user.favorites.includes(:favoritable)
  end

  def create
    @favoritable = params[:favoritable_type].constantize.find(params[:favoritable_id])
    @favorite = current_user.favorites.create(favoritable: @favoritable)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: dashboard_path  }
    end
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
end
