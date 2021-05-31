# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def download?
    index?
  end

  def voice?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
