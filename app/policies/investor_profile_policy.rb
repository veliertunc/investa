# frozen_string_literal: true

class InvestorProfilePolicy < ApplicationPolicy
  # Only show all profiles to founders who have startup
  def index?
    founder_has_startup?
  end

  # Only show to the profile owner or founders looking for investors
  def show?
    investor_profile? or founder_has_startup?
  end

  def create?
    investor_has_no_investor_profile?
  end

  def update?
    investor_profile?
  end

  private

  def investor_profile?
    investor_has_investor_profile? and (user.investor_profile == record)
  end
end
