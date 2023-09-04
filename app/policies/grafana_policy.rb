# frozen_string_literal: true

class GrafanaPolicy
  attr_reader :user

  def initialize(user, _record)
    @user = user
  end

  def show?
    ENV["GF_DASHBOARD_URL"].present? &&
    (user.system_admin? || user.gf_user_id.present?)
  end
end
