# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, "must be logged in" unless user
      @user = user
      @scope = scope
    end

    def resolve
      raise NoMethodError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end

  protected

  # Does the startup belongs to the user
  def founder_has_startup?
    (user.is_a?(User) and user.founder? and user.startup.present?)
  end

  def founder_has_no_startup?
    (user.is_a?(User) and user.founder? and not user.startup.present?)
  end

  def investor_has_investor_profile?
    (user.is_a?(User) and user.investor? and user.investor_profile.present?)
  end

  def investor_has_no_investor_profile?
    (user.is_a?(User) and user.investor? and not user.investor_profile.present?)
  end

  def admin_index?
    (user.is_a?(AdminUser))
  end

  def admin_show?
    (user.is_a?(AdminUser))
  end

  def admin_create?
    (user.is_a?(AdminUser) and user.super_admin?)
  end

  def admin_update?
    (user.is_a?(AdminUser) and user.super_admin?)
  end

  def admin_destroy?
    (user.is_a?(AdminUser) and user.super_admin?)
  end
end
