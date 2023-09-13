# frozen_string_literal: true

class AccountPolicy < ApplicationPolicy
  def index?
    create?
  end

  def create?
    user.system_admin? || user.admin?
  end

  def update?
    create?
  end

  def destroy?
    archive? && record.deleted?
  end

  def restore?
    record.deleted?
  end

  def archive?
    return false if record.id == user.id

    create? && !record.system_admin?
  end

  def resend_confirmation?
    update?
  end

  def enable_dashboard?
    update? && record.confirmed? && !record.dashboard_accessible?
  end

  def disable_dashboard?
    update? && record.confirmed? && record.dashboard_accessible?
  end

  def roles
    if user.system_admin?
      Account::ROLES
    else
      Account.roles.keys.reject { |r| r == "system_admin" }.map { |r| [r.titlecase, r] }
    end
  end

  class Scope < Scope
    def resolve
      return scope.all if user.system_admin?

      scope.where.not(role: :system_admin)
    end
  end
end
