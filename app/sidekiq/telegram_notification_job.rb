# frozen_string_literal: true

class TelegramNotificationJob
  include Sidekiq::Job

  def perform(quiz_id, chat_group_id)
    quiz = Quiz.find(quiz_id)
    chat_group = ChatGroup.find(chat_group_id)

    quiz.notify(chat_group)
  end
end
