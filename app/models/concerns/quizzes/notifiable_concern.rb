# frozen_string_literal: true

module Quizzes::NotifiableConcern
  extend ActiveSupport::Concern

  included do
    def notify_groups_async(chat_groups)
      chat_groups.each do |chat_group|
        TelegramNotificationJob.perform_async(id, chat_group.id)
      end
    end

    def notify(chat_group)
      ::TelegramBot.client_send_message(chat_group.chat_id, message)
    rescue ::Telegram::Bot::Forbidden => e
      chat_group.update(active: false, reason: e)
    end

    def message
      sms = [user.profile_html]
      sms.push("#{I18n.t('form.survey')}: ")

      form.questions.each do |question|
        answer = answers.select { |ans| ans.question_id == question.id }.first
        sms.push("#{question.name} <b>(#{answer.try(:value)})</b>") if answer.present?
      end

      sms.join(" | ")
    end
  end
end
