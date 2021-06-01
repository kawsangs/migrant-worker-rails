# frozen_string_literal: true

class NotificationsController < ApplicationController
  def index
    @pagy, @notifications = pagy(Notification.order("updated_at DESC"))
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new(notification_params)

    if @notification.save
      redirect_to notifications_url
    else
      render :new
    end
  end

  def edit
    @notification = Notification.find(params[:id])
  end

  def update
    @notification = Notification.find(params[:id])

    if @notification.update(notification_params)
      redirect_to notifications_url
    else
      render :edit
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    redirect_to notifications_url
  end

  private
    def notification_params
      params.require(:notification).permit(
        :id, :title, :body, :success_count, :failure_count
      )
    end
end
