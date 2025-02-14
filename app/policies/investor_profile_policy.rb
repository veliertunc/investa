# frozen_string_literal: true

class InvestorProfilePolicy < ApplicationPolicy
  def create?
    user.investor? and not user.investor_profile.present?
  end

  def update?
    user_investor_profile?
  end

  private

  def user_investor_profile?
    user_has_investor_profile? and (user.investor_profile == record)
  end
end
