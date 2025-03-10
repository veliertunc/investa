# frozen_string_literal: true

class ListingPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.is_a?(AdminUser)
        scope.all
      else
        if user.investor?
          scope.all
        elsif user.founder?
          scope.where(startup: user.startup)
        else
          scope.none
        end
      end
    end
  end

  def index?
    permitted = founder_has_startup? or investor_has_investor_profile?
    permitted or admin_index?
  end

  def show?
    permitted = startup_listing? or investor_has_investor_profile?
    permitted or admin_show?
  end

  def create?
    permitted = founder_has_startup?
    permitted or admin_create?
  end

  def update?
    permitted = startup_listing?
    permitted or admin_update?
  end

  def destroy?
    permitted = startup_listing?
    permitted or admin_destroy?
  end

  # Only allow the startup founder (which can be found through startup.listings)
  # to kist the investment proposals for the current listing.
  def list_proposals?
    startup_listing?
  end

  private

  # Does the startup belongs to the user
  def startup_listing?
    founder_has_startup? and user.startup.listings.any?(record)
  end
end
