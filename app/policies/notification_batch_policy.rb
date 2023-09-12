# frozen_string_literal: true

class NotificationBatchPolicy < ApplicationPolicy
  def index?
    create?
  end

  def update?
    false
  end

  def create?
    user.system_admin? || user.admin?
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
