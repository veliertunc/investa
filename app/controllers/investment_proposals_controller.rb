class InvestmentProposalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [ :create, :new ]
  before_action :set_proposal, only: [ :show, :edit, :update ]

  def index
    authorize InvestmentProposal
    @proposals = policy_scope(InvestmentProposal)
  end

  def show
    authorize @proposal
  end

  def new
    authorize InvestmentProposal
    @proposal = @listing.investment_proposals.new
    @proposal.investor_profile = current_user.investor_profile
  end

  def create
    authorize InvestmentProposal
    @proposal = @listing.investment_proposals.new(proposal_params)
    @proposal.investor_profile = current_user.investor_profile

    if @proposal.save
      redirect_to @listing, notice: "Proposal submitted successfully."
    else
      render :new
    end
  end

  def edit
    authorize @proposal
  end

  def update
    authorize @proposal

    if @proposal.update(proposal_params)
      redirect_to listing_path(@proposal.listing), notice: "Proposal updated successfully."
    else
      render :show
    end
  end

  private

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

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end
end
