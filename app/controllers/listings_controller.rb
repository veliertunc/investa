class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_startup_owner, except: [ :index, :show ]

  def index
    @listings = Listing.active.includes(:startup)
  end

  def show
    @investment_proposal = InvestmentProposal.new
  end

  def new
    @startup = current_user.startup
    @listing = @startup.listings.new
  end

  def create
    @listing = current_user.startup.listings.new(listing_params)
    if @listing.save
      redirect_to @listing, notice: "Listing was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to @listing, notice: "Listing was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @listing.destroy
    redirect_to startup_path(@listing.startup), notice: "Listing was successfully deleted."
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :funding_goal, :equity_offered, :status)
  end

  def authorize_startup_owner
    return if current_user.startup == @listing&.startup
    redirect_to listings_path, alert: "You can only manage your own startup's listings."
  end
end
