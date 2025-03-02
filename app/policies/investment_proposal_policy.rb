class InvestmentProposalPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      case user.role.to_sym
      when :investor
        scope.where(investor_profile: user.investor_profile)
      else
        scope.none
      end
    end
  end

  def index?
    investor_has_investor_profile?
  end

  def show?
    investor_proposal?
  end

  def create?
    investor_has_investor_profile?
  end

  # Only allow to update/edit the pending ones
  def update?
    investor_proposal? and record.pending?
  end

  private

  # Does the user have a profile and it belong to the user
  def investor_proposal?
    investor_has_investor_profile? and user.investor_profile == record.investor_profile and user.investment_proposals.any?(record)
  end
end
