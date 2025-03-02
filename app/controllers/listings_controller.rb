class ListingsController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!
  before_action :set_listing, only: [ :show, :edit, :update, :destroy ]

  def index
    authorize Listing

    case current_user.role.to_sym
    when :founder
      displayed_listings = current_user.startup.listings
    when :investor
      displayed_listings = Listing.all
    end
    # TODO: Sanitize query params
    @q = displayed_listings.ransack(params[:q])

    @pagy, @listings = pagy(@q.result(distinct: true).includes(:startup).order(created_at: :desc))
  end

  def show
    authorize @listing
    @investment_proposal = InvestmentProposal.new
  end

  def new
    authorize Listing
    @listing = @startup.listings.new
  end

  def create
    authorize Listing
    @listing = @startup.listings.new(listing_params)

    if @listing.save
      redirect_to @listing, notice: "Listing was successfully created."
    else
      render :new
    end
  end

  def edit
    authorize @listing
  end

  def update
    authorize @listing

    if @listing.update(listing_params)
      redirect_to @listing, notice: "Listing was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @listing

    @listing.destroy
    redirect_to startup_path(current_user.startup), notice: "Listing was successfully deleted."
  end

  def method_name
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :funding_goal, :equity_offered, :status)
  end
end
