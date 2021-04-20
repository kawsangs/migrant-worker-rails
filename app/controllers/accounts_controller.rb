# frozen_string_literal: true

class AccountsController < ApplicationController
  def index
    @pagy, @accounts = pagy(policy_scope(authorize Account.filter(params)))
  end

  def new
    @account = authorize Account.new
  end

  def create
    @account = authorize Account.new(account_params)

    if @account.save
      @account.send_confirmation_instruction_async
      redirect_to accounts_url
    else
      flash.now[:alert] = @account.errors.full_messages
      render :new
    end
  end

  def edit
    @account = authorize Account.find(params[:id])
  end

  def update
    @account = authorize Account.find(params[:id])

    if @account.update_attributes(account_params)
      redirect_to accounts_url
    else
      flash.now[:alert] = @account.errors.full_messages
      render :edit
    end
  end

  def destroy
    @account = authorize Account.find(params[:id])
    @account.destroy

    redirect_to accounts_url
  end

  def update_locale
    current_account.language_code = locale_params[:language_code]
    if current_account.save
      head :ok
    else
      render json: current_account.errors.messages
    end
  end

  private
    def account_params
      params.require(:account).permit(:email, :role)
    end

    def locale_params
      params.require(:account).permit(:language_code)
    end
end
