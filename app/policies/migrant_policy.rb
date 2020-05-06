class MigrantPolicy < ApplicationPolicy
  def index?
    true
  end

  def download?
    index?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
