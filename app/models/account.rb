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
#
class Account < ApplicationRecord
  include Accounts::Confirmable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  enum role: {
    system_admin: 1,
    guest: 2
  }

  ROLES = roles.keys.map { |r| [r.titlecase, r] }

  def send_confirmation_instruction_async
    AccountWorker.perform_async(id, :send_confirmation_instructions)
  end

  def self.filter(params)
    scope = all
    scope = scope.where("email LIKE ?", "%#{params[:email]}%") if params[:email].present?
    scope
  end

  def self.from_omniauth(access_token)
    self.where(email: access_token.info["email"]).first
  end

  def display_name
    email.split("@").first.upcase
  end
end
