# frozen_string_literal: true

class AccountPolicy < ApplicationPolicy
  def index?
    user.system_admin?
  end

  def create?
    user.system_admin?
  end

  def update?
    create?
  end

  def destroy?
    return false if record.id == user.id
    return true if user.system_admin?
    false
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
      scope.all
    end
  end
end
