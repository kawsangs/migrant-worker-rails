# frozen_string_literal: true

class GrafanaPolicy
  attr_reader :user

  def initialize(user, _record)
    @user = user
  end

  def show?
    return false if ENV["GF_DASHBOARD_URL"].blank?

    user.gf_user_id.present?
  end
end
