# frozen_string_literal: true

class StartupPolicy < ApplicationPolicy
  def create?
    user.founder? and not user.startup.present?
  end

  def update?
    startup_owner?
  end

  def destroy?
    startup_owner?
  end

  private

  # Does the startup belongs to the user
  def startup_owner?
    user_has_startup? and (user.startup == record)
  end
end
