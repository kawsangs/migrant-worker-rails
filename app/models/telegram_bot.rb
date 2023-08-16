# frozen_string_literal: true

# == Schema Information
#
# Table name: telegram_bots
#
#  id                   :uuid             not null, primary key
#  token                :string
#  username             :string
#  telegram_bot_user_id :string
#  enabled              :boolean          default(FALSE)
#  active               :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class TelegramBot < ApplicationRecord
  attr_accessor :skip_callback

  # Association
  has_many :chat_groups, foreign_key: :telegram_bot_user_id, primary_key: :telegram_bot_user_id

  # Validation
  validates :token, :username, presence: true, if: :enabled?

  # Callback
  before_commit :post_webhook_to_telegram, on: [:create, :update], unless: :skip_callback

  def post_webhook_to_telegram
    bot = Telegram::Bot::Client.new(token: token, username: username)

    begin
      request = bot.set_webhook(url: ENV["TELEGRAM_CALLBACK_URL"])

      set_status_active_and_user_id(request)
    rescue
      self.active = false
    end
  end

  def self.instance
    self.first || self.new
  end

  private
    def set_status_active_and_user_id(request)
      self.active = request["ok"]
      self.telegram_bot_user_id = token.to_s.split(":").first
    end
end
