# frozen_string_literal: true

class VisitPolicy < ApplicationPolicy
  def index?
    user.primary_admin?
  end

  def create?
    true
  end

  def update?
    false
  end

  def destroy?
    false
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
