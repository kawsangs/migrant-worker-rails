# frozen_string_literal: true

class NotificationPolicy < ApplicationPolicy
  def index?
    create?
  end

  def update?
    create? && record.draft?
  end

  def create?
    user.system_admin? || user.admin?
  end

  def destroy?
    update?
  end

  def release?
    update?
  end

  def cancel?
    create? && record.released? && !record.completed?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
