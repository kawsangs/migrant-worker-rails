class AccountsController < ApplicationController
  def index
    @accounts = authorize Account.all
  end

  def new
    @account = authorize Account.new
  end

  def create
    @account = authorize Account.new(account_params)

    if @account.save
      # AccountWorker.perform_async(@account.id)
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

  private
    def account_params
      params.require(:account).permit(:email, :role)
    end
end
