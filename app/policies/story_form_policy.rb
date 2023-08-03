# frozen_string_literal: true

class StoryFormPolicy < ApplicationPolicy
  def index?
    create?
  end

  def update?
    create?
  end

  def create?
    user.system_admin?
  end

  def destroy?
    create?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
