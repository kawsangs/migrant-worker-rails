# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  def index?
    create?
  end

  def show?
    index?
  end

  def create?
    user.system_admin? || user.admin?
  end

  def update?
    create?
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
