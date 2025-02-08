class InvestmentProposalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [ :create ]
  before_action :set_proposal, only: [ :show, :update, :edit ]
  before_action :authorize_investor, only: [ :create, :update, :edit ]
  before_action :authorize_startup_owner, only: [ :update ]

  def index
    @proposals = current_user.investment_proposals
  end

  def edit
  end

  def create
    @proposal = @listing.investment_proposals.new(proposal_params)
    @proposal.investor_profile = current_user.investor_profile

    if @proposal.save
      redirect_to @listing, notice: "Proposal submitted successfully."
    else
      render "listings/show"
    end
  end

  def update
    if @proposal.update(proposal_params)
      redirect_to listing_path(@proposal.listing), notice: "Proposal updated successfully."
    else
      render :show
    end
  end

  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def set_proposal
    @proposal = InvestmentProposal.find(params[:id])
  end

  def proposal_params
    params.require(:investment_proposal).permit(
      :amount,
      :equity_requested,
      :status
    )
  end

  def authorize_investor
    redirect_to listings_path, alert: "Only investors can perform this operation" unless current_user.investor?
  end

  def authorize_startup_owner
    redirect_to listings_path, alert: "Unauthorized" unless current_user.investment_proposals.any?(@proposal)
  end
end
