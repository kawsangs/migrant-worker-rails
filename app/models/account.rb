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
#
class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  enum role: {
    system_admin: 1,
    guest: 2
  }

  ROLES = roles.keys.map { |r| [r.titlecase, r] }

  def password_match?(params)
    errors[:password] << I18n.t('errors.messages.blank') if params[:password].blank?
    errors[:password_confirmation] << I18n.t('errors.messages.blank') if params[:password_confirmation].blank?
    errors[:password_confirmation] << I18n.translate('errors.messages.confirmation_miss_match', attribute: 'password') if params[:password] != params[:password_confirmation]

    params[:password] == params[:password_confirmation] && params[:password].present?
  end

  # new function to return whether a password has been set
  def no_password?
    encrypted_password.blank?
  end

  # Devise::Models:unless_confirmed` method doesn't exist in Devise 2.0.0 anymore.
  # Instead you should use `pending_any_confirmation`.
  def only_if_unconfirmed
    pending_any_confirmation { yield }
  end

  def send_confirmation_instruction_async
    AccountWorker.perform_async(id, :send_confirmation_instructions)
  end

  def self.filter(params)
    scope = all
    scope = scope.where('email LIKE ?', "%#{params[:email]}%") if params[:email].present?
    scope
  end

  def self.from_omniauth(access_token)
    self.where(email: access_token.info['email']).first
  end

  protected
    def password_required?
      confirmed? ? super : false
    end
end
