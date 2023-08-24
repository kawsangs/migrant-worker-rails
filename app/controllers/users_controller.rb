# frozen_string_literal: true

class UsersController < ApplicationController
  helper_method :filter_params

  def index
    @pagy, @users = pagy(policy_scope(authorize User.filter(filter_params).includes(:surveys)))
  end

  def download
    users = policy_scope(authorize User.filter(filter_params))

    if users.length > Settings.max_download_record
      flash[:alert] = t("shared.file_size_is_too_big", max_record: Settings.max_download_record)
      redirect_to users_url
    else
      send_data(::UserService.new(users).export, filename: "users_#{Time.new.strftime('%Y%m%d_%H_%M_%S')}.xls")
    end
  end

  private
    def filter_params
      params.permit(:full_name, :start_date, :end_date, :start_age, :end_age, genders: [])
    end
end
