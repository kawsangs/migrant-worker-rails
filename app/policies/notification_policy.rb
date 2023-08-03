# frozen_string_literal: true

class NotificationPolicy < ApplicationPolicy
  def index?
    create?
  end

  def update?
    create? && !record.published?
  end

  def create?
    user.system_admin?
  end

  def destroy?
    update?
  end

  def publish?
    update?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
