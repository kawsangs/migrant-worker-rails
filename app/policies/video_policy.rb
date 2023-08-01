# frozen_string_literal: true

class VideoPolicy < ApplicationPolicy
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
