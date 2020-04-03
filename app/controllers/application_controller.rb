class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

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
      I18n.locale = params[:locale] || I18n.default_locale
    end
end
