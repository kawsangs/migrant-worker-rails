# frozen_string_literal: true

class NotificationOccurenceJob
  include Sidekiq::Job

  def perform(notification_occurence_id)
    notification_occurence = NotificationOccurence.find(notification_occurence_id)
    notification_occurence.notify_all_token_async
  end
end
