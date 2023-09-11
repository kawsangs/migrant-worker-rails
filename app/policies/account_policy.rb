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
    record.confirmed? && record.gf_user_id.blank?
  end

  def disable_dashboard?
    record.confirmed? && record.gf_user_id.present?
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
