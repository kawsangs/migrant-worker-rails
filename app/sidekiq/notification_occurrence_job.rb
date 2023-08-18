# frozen_string_literal: true

class NotificationOccurrenceJob
  include Sidekiq::Job

  def perform(notification_occurrence_id)
    notification_occurrence = NotificationOccurrence.find(notification_occurrence_id)
    notification_occurrence.notify_all_token_async
  end
end
