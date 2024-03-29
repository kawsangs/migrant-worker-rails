# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authorize_notification, only: [:show, :edit, :update, :destroy, :release, :cancel]

  def index
    @pagy, @notifications = pagy(authorize Notification.filter(filter_params).includes(:notification_occurrences, :canceller, :releasor, survey_form: [questions: :options]))
  end

  def show
  end

  def new
    @notification = authorize Notification.new
  end

  def create
    @notification = authorize Notification.new(notification_params)

    if @notification.save
      redirect_to notifications_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @notification.update(notification_params)
      redirect_to notifications_url
    else
      render :edit
    end
  end

  def destroy
    if @notification.destroy
      redirect_to notifications_url, flash: { notice: I18n.t("notification.delete_successfully") }
    else
      redirect_to notifications_url, flash: { alert: @notification.errors.full_messages }
    end
  end

  def release
    if @notification.released_by(current_account.id)
      redirect_to notifications_url, flash: { notice: I18n.t("notification.release_successfully") }
    else
      redirect_to notifications_url, flash: { alert: @notification.errors.full_messages }
    end
  end

  def cancel
    if @notification.cancelled_by(current_account.id)
      redirect_to notifications_url, flash: { notice: I18n.t("notification.cancel_successfully") }
    else
      redirect_to notifications_url, flash: { alert: @notification.errors.full_messages }
    end
  end

  private
    def notification_params
      params.require(:notification).permit(
        :id, :title, :body, :form_id, :schedule_mode,
        :start_time, :end_time, :recurrence_rule
      )
    end

    def authorize_notification
      @notification = authorize Notification.find(params[:id])
    end

    def filter_params
      params.permit(:start_date, :end_date, :form_id, status: [])
    end
    helper_method :filter_params
end
