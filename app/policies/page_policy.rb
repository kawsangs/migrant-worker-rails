# frozen_string_literal: true

class PagePolicy < ApplicationPolicy
  def index?
    user.system_admin?
  end

  def show?
    index?
  end

  def create?
    user.system_admin?
  end

  def update?
    user.system_admin?
  end

  def destroy?
    create? && record.visits_count.to_i.zero?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
