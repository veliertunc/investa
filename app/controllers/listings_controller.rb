class ListingsController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!
  before_action :set_listing, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_startup_owner, only: [ :edit, :update, :destroy ]
  before_action :set_startup, only: [ :new, :create ]

  # TODO: Fix business logic and other bugs

  def index
      case current_user.role.to_sym
      when :founder
        displayed_listings = current_user.startup.listings.active
      when :investor
        displayed_listings = Listing.active
      end

      @q = displayed_listings.ransack(params[:q])
      @pagy, @listings = pagy(@q.result.includes(:startup).order(created_at: :desc))
  end

  def show
    @investment_proposal = InvestmentProposal.new
  end

  def new
    @listing = @startup.listings.new
  end

  def create
    @listing = @startup.listings.new(listing_params)
    if @listing.save
      redirect_to @listing, notice: "Listing was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    puts @listing.startup
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

  # If not user.startup.present? or
  #   user.startup != listing.startup redirect to dashboard
  def authorize_startup_owner
    redirect_to dashboard_path, alert: "You are not authorized to do this action." unless current_user.startup.listings.any?(@listing)
  end

  def set_startup
    @startup = current_user.startup if @startup.nil?
  end
end
