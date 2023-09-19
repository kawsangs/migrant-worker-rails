# frozen_string_literal: true

class GooglePlayPolicy
  attr_reader :user

  def initialize(user, _record)
    @user = user
  end

  def show?
    return false if ENV["GOOGLE_PLAY_DASHBOARD_URL"].blank?

    user.system_admin? || user.admin?
  end
end
