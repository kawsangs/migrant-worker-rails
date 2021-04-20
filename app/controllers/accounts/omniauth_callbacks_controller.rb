# frozen_string_literal: true

class Accounts::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @account = Account.from_omniauth(request.env["omniauth.auth"])

    if @account.nil?
      redirect_to new_account_session_path, alert: I18n.t("devise.no_account")
      return
    end

    if @account.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Google"
      sign_in_and_redirect @account, event: :authentication
    end
  end
end
