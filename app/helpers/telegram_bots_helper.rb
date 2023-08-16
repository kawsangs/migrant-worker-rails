# frozen_string_literal: true

module TelegramBotsHelper
  def bot_status(bot)
    if bot.enabled? && bot.active?
      return "<i class='far fa-check-circle text-success' data-toggle='tooltip' title='#{t('telegram_bot.valid_bot')}'></i>"
    end

    "<i class='far fa-times-circle text-danger' data-toggle='tooltip' title='#{t('telegram_bot.invalid_bot')}'></i>"
  end
end
