# frozen_string_literal: true

class StartupPolicy < ApplicationPolicy
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
end
