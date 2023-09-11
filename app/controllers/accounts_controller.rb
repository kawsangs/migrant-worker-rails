# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :set_account, only: %i[edit update archive resend_confirmation enable_dashboard disable_dashboard]

  def index
    @pagy, @accounts = pagy(policy_scope(authorize Account.filter(filter_params)))
  end

  def new
    @account = authorize Account.new
  end

  def create
    @account = authorize Account.new(account_params)

    if @account.save
      redirect_to accounts_url
    else
      flash.now[:alert] = @account.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @account.update(account_params)
      redirect_to accounts_url, notice: "Account was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def archive
    @account.destroy

    redirect_to accounts_url, status: :see_other, notice: I18n.t("account.archive_successfully", email: @account.email)
  end

  def restore
    @account = authorize Account.only_deleted.find(params[:id])
    @account.restore

    redirect_to accounts_url, notice: I18n.t("account.restore_successfully", email: @account.email)
  end

  def destroy
    @account = authorize Account.only_deleted.find(params[:id])
    @account.really_destroy!

    redirect_to accounts_url(archived: true)
  end

  def resend_confirmation
    @account.send_confirmation_instructions

    redirect_to accounts_url, notice: I18n.t("account.resend_confirmation_successfully")
  end

  def enable_dashboard
    @account.add_to_grafana_async

    redirect_to accounts_url, notice: I18n.t("account.enable_dashboard_successfully", email: @account.email)
  end

  def disable_dashboard
    @account.remove_from_grafana_async

    redirect_to accounts_url, notice: I18n.t("account.disable_dashboard_successfully", email: @account.email)
  end

  private
    def account_params
      params.require(:account).permit(:email, :role)
    end

    def set_account
      @account = authorize Account.find(params[:id])
    end

    def filter_params
      params.permit(:email, :archived)
    end

    def filter_params
      params.permit(:email, :start_date, :end_date)
    end
end
