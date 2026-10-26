class ListingsController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!
  before_action :set_listing, only: [ :show, :edit, :update, :destroy ]
  before_action :set_startup, only: [ :new, :create ]

  def index
    authorize Listing

    @q = policy_scope(Listing).ransack(params[:q])

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

  private

  def set_listing
    @listing = policy_scope(Listing).find(params[:id])
  end

  def set_startup
    @startup = current_user.startup || raise(ActiveRecord::RecordNotFound)
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :funding_goal, :funding_goal_currency, :equity_offered)
  end
end
