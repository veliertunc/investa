# frozen_string_literal: true

class StartupPolicy < ApplicationPolicy
  def create?
    user.founder? and not user.startup.present?
  end

  def update?
    user_startup?
  end

  def destroy?
    user_startup?
  end

  private

  # Does the startup belongs to the user
  def user_startup?
    user.founder? and user.startup.present? and (user.startup == record)
  end
end
