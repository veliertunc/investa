# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.is_a?(AdminUser)
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end

  def index?
    permitted = user.present?
    (permitted or admin_index?)
  end

  def show?
    permitted = user.present?
    (permitted or admin_show?)
  end

  def create?
    permitted = (not user.present?)
    (permitted or admin_create?)
  end

  def update?
    permitted = (user.present? and (user == record))
    (permitted or admin_update?)
  end

  def destroy?
    permitted = (user.present? and (user == record))
    (permitted or admin_destroy?)
  end
end
