# frozen_string_literal: true

class InvestmentProposalPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.is_a?(AdminUser)
        scope.all
      else
        if user.investor?
          scope.where(investor_profile: user.investor_profile)
        elsif user.founder?
          scope.startup_proposals(user.startup)
        else
          scope.none
        end
      end
    end
  end

  def index?
    permitted = investor_has_investor_profile? or founder_has_startup?
    permitted or admin_index?
  end

  def show?
    permitted = investor_proposal? or startup_proposal?
    permitted or admin_show?
  end

  def create?
    permitted = investor_has_investor_profile?
    permitted or admin_create?
  end

  # Only allow to update/edit the pending ones
  def update?
    permitted = (investor_proposal? and record.pending?)
    permitted or admin_update?
  end

  def destroy?
    admin_destroy?
  end

  def accept?
    startup_proposal?
  end

  def reject?
    startup_proposal?
  end

  private

  # Does the user have a profile and it belong to the user
  def investor_proposal?
    investor_has_investor_profile? and (user.investor_profile == record.investor_profile) and user.investment_proposals.any?(record)
  end

  def startup_proposal?
    founder_has_startup? and (user.startup == record.listing.startup)
  end
end
