# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend

  rescue_from ::Pundit::NotAuthorizedError, with: :render_unauthorized

  protect_from_forgery prepend: true

  before_action :authenticate_account!
  before_action :set_locale

  layout :layout_by_resource

  def pundit_user
    current_account
  end

  private
    def layout_by_resource
      devise_controller? ? "minimal" : "application"
    end

    def set_locale
      I18n.locale = current_account.try(:language_code) || I18n.default_locale
    end

    def render_unauthorized
      flash[:alert] = I18n.t("shared.unauthorized_alert_message")
      redirect_to(request.referrer || root_path)
    end
end
