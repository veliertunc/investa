# frozen_string_literal: true

class ListingPolicy < ApplicationPolicy
  # Only allow the startup founder (which can be found through startup.listings)
  # to kist the investment proposals for the current listing.
  def list_proposals?
    startup_listing?
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

  private

  # Does the startup belongs to the user
  def startup_listing?
    founder_has_startup? and user.startup.listings.any?(record)
  end
end
