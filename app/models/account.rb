# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  role                   :integer          not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  language_code          :string           default("en")
#  gf_user_id             :integer
#  deleted_at             :datetime
#  actived                :boolean          default(TRUE)
#  dashboard_accessible   :boolean          default(FALSE)
#
class Account < ApplicationRecord
  acts_as_paranoid

  attr_accessor :skip_callback

  include Accounts::Confirmable
  include Accounts::GrafanaConcern
  include Accounts::OauthProvider
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  enum role: {
    system_admin: 1,
    admin: 3,
    guest: 2
  }

  default_scope { order("created_at desc") }

  ROLES = roles.keys.map { |r| [r.titlecase, r] }

  def self.filter(params = {})
    scope = all
    scope = scope.where("email LIKE ?", "%#{params[:email].strip}%") if params[:email].present?
    scope = scope.where("created_at BETWEEN ? AND ?", DateTime.parse(params[:start_date]).beginning_of_day, DateTime.parse(params[:end_date]).end_of_day) if params[:start_date].present? && params[:end_date].present?
    scope = scope.only_deleted if params[:archived] == "true"
    scope
  end

  def self.from_omniauth(access_token)
    self.where(email: access_token.info["email"]).first
  end

  def display_name
    email.split("@").first.upcase
  end

  def status
    return "archived" if deleted?
    return "actived" if confirmed?

    "pending"
  end
end
