class VideoBatchPolicy < ApplicationPolicy
  def index?
    create?
  end

  def create?
    user.system_admin? || admin?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end