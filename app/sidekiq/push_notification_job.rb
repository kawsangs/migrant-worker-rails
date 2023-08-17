# frozen_string_literal: true

class PushNotificationJob
  include Sidekiq::Job

  def perform(notification_occurrence_id, token_id)
    notification_occurrence = NotificationOccurrence.find(notification_occurrence_id)
    registered_token = RegisteredToken.find(token_id)

    response = notification_occurrence.notify(registered_token)
    notification_occurrence.update_progress_status(response, registered_token)
  end
end
