class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_params, only: [ :create, :destroy ]
  before_action :find_bookmarkable, only: [ :create, :destroy ]

  def index
    @favorites = current_user.favorites
  end

  def create
    # bookmarkable = favorite_params
    current_user.favorites.create(bookmarkable: @bookmarkable)
    redirect_back fallback_location: @bookmarkable
  rescue ActiveRecord::RecordInvalid
    redirect_back fallback_location: root_path, alert: "Already in favorites"
  end

  def destroy
    # bookmarkable = params[:id]
    favorite = current_user.favorites.find_by(bookmarkable: @bookmarkable)
    favorite&.destroy
    redirect_back fallback_location: @bookmarkable
  end


  private

  def favorite_params
    params.require(:bookmarkable).permit(:id, :type)
  end

  def validate_params
    requested_type = favorite_params[:type].to_s.classify

    return head :bad_request unless Favorite::BOOKMARKABLE_TYPES.include?(requested_type)
  end

  def find_bookmarkable
    # Find bookmarkable based on *_id params
    requested_type = favorite_params[:type].to_s.classify

    @bookmarkable = requested_type.safe_constantize.find(favorite_params[:id])
  end
end
