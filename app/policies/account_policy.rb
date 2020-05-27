# frozen_string_literal: true

class AccountPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.system_admin?
  end

  def create?
    user.system_admin?
  end

  def new?
    create?
  end

  def update?
    user.system_admin?
  end

  def edit?
    update?
  end

  def destroy?
    user.system_admin?
  end

  def roles
    if user.system_admin?
      Account::ROLES
    else
      Account.roles.keys.reject { |r| r == 'system_admin' }.map { |r| [r.titlecase, r] }
    end
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
