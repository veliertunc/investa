# frozen_string_literal: true

class AdminUserPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      user.is_a?(AdminUser) ? scope.all : scope.none
    end
  end

  def index?
    admin_index?
  end

  def show?
    admin_show?
  end

  def create?
    admin_create?
  end

  def update?
   (admin_update? or (user == record))
  end

  def destroy?
    (admin_destroy? or (user == record))
  end
end
