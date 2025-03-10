# frozen_string_literal: true

class InvestorProfilePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.is_a?(AdminUser)
        scope.all
      else
        if user.investor?
          scope.where(user: user)
        elsif user.founder?
          scope.all
        else
          scope.none
        end
      end
    end
  end

  # Only show all profiles to founders who have startup
  def index?
    permitted = founder_has_startup?
    permitted or admin_index?
  end

  # Only show to the profile owner or founders looking for investors
  def show?
    permitted = investor_profile? or founder_has_startup?
    permitted or admin_show?
  end

  def create?
    permitted = investor_has_no_investor_profile?
    permitted or admin_create?
  end

  def update?
    permitted = investor_profile?
    permitted or admin_update?
  end

  def destroy?
    admin_destroy?
  end

  def noninvestor_actions?
    founder_has_startup?
  end

  private

  def investor_profile?
    investor_has_investor_profile? and (user.investor_profile == record)
  end
end
