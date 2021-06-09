# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @pagy, @users = pagy(policy_scope(authorize User.filter(params).newest.includes(:quizzes)))
  end

  def download
    users = policy_scope(authorize User.filter(params))

    if users.length > ENV["MAXIMUM_DOWNLOAD_RECORDS"].to_i
      flash[:alert] = t("users.file_size_is_too_big")
      redirect_to users_url
    else
      send_data(::UserService.new(users).export, filename: "users.xls")
    end
  end
end
