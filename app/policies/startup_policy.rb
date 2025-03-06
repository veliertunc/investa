# frozen_string_literal: true

class StartupPolicy < ApplicationPolicy
  def index?
    investor_has_investor_profile?
  end

  def show?
    startup_owner? or investor_has_investor_profile?
  end

  def create?
    founder_has_no_startup?
  end

  def update?
    startup_owner?
  end

  def destroy?
    startup_owner?
  end

  def startup_owner?
    founder_has_startup? and (user.startup == record)
  end

  def investor_actions?
    investor_has_investor_profile?
  end
end
