class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_user, except: [ :index, :show ]

  def index
    @listings = Listing.active.includes(:startup).order(created_at: :desc)
  end

  def show
    @startup = @listing.startup
  end

  def new
    @startup = current_user.startup
    @listing = @startup.listings.new
  end

  def create
    @startup = current_user.startup
    @listing = @startup.listings.new(listing_params)

    if @listing.save
      redirect_to startup_path(@startup), notice: "Listing was successfully created."
    else
      render :new
    end
  end

  def edit
    @startup = @listing.startup
  end

  def update
    if @listing.update(listing_params)
      redirect_to startup_path(@listing.startup), notice: "Listing was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @listing.destroy
    redirect_to startup_path(@listing.startup), notice: "Listing was successfully removed."
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(
      :title,
      :description,
      :funding_goal,
      :equity_offered,
      :status
    )
  end

  def authorize_user
    return if current_user.founder? && @listing.startup.user == current_user

    redirect_to root_path, alert: "You're not authorized to perform this action."
  end
end
