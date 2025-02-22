# frozen_string_literal: true

class InvestorProfilePolicy < ApplicationPolicy
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
