class InvestmentProposalPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(investor_profile: user.investor_profile)
    end
  end

  def index?
    investor_has_investor_profile?
  end

  def create?
    investor_has_investor_profile?
  end

  def show?
    investor_proposal?
  end

  # Only allow to update/edit the pending ones
  def update?
    investor_proposal? and record.pending?
  end

  private

  # Does the user have a profile and
  # does it belong to the user
  def investor_proposal?
    investor_has_investor_profile? and user.investor_profile == record.investor_profile and user.investment_proposals.any?(record)
  end
end
