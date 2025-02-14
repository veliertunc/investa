# frozen_string_literal: true

class ListingPolicy < ApplicationPolicy
  def list_proposals?
    startup_listing?
  end

  def create?
    user_has_startup?
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
    user_has_startup? and user.startup.listings.any?(record)
  end
end
