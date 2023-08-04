# frozen_string_literal: true

class SurveyFormPolicy < ApplicationPolicy
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
    create? && record.notifications.length.zero?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
