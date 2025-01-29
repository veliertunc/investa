class InvestmentProposalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing
  before_action :authorize_investor

  def create
    @proposal = @listing.investment_proposals.new(proposal_params)
    @proposal.investor_profile = current_user.investor_profile

    if @proposal.save
      Notification.create(
        user: @listing.startup.user,
        message: "New investment proposal for #{@listing.title}",
        link: listing_path(@listing)
      )
      redirect_to @listing, notice: "Proposal submitted successfully."
    else
      render "listings/show"
    end
  end

  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def proposal_params
    params.require(:investment_proposal).permit(:amount, :equity_requested, :message)
  end

  def authorize_investor
    redirect_to listings_path, alert: "Only investors can submit proposals." unless current_user.investor?
  end
end
