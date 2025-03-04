# frozen_string_literal: true

class ListingPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      case user.role.to_sym
      when :investor
        scope.all
      when :founder
        scope.where(startup: user.startup)
      else
        scope.none
      end
    end
  end

  def index?
    founder_has_startup? or investor_has_investor_profile?
  end

  def show?
    startup_listing? or investor_has_investor_profile?
  end

  def create?
    founder_has_startup?
  end

  def update?
    startup_listing?
  end

  def destroy?
    startup_listing?
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
