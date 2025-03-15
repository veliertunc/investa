# frozen_string_literal: true

class StartupPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.is_a?(AdminUser)
        scope.all
      else
        if user.investor?
          scope.all
        elsif user.founder?
          scope.where(user: user)
        else
          scope.none
        end
      end
    end
  end

  def index?
    permitted = investor_has_investor_profile?
    permitted or admin_index?
  end

  def show?
    permitted = (startup_owner? or investor_has_investor_profile?)
    (permitted or admin_show?)
  end

  def create?
    permitted = founder_has_no_startup?
    (permitted or admin_create?)
  end

  def update?
    permitted = startup_owner?
    (permitted or admin_update?)
  end

  def destroy?
    permitted = startup_owner?
    (permitted or admin_destroy?)
  end

  def startup_owner?
    (founder_has_startup? and (user.startup == record))
  end

  def investor_actions?
    investor_has_investor_profile?
  end
end
