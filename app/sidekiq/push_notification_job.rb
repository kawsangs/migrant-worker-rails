# frozen_string_literal: true

class PushNotificationJob
  include Sidekiq::Job

  def perform(notification_occurrence_id, token_id)
    notification_occurence = NotificationOccurence.find(notification_occurrence_id)
    registered_token = RegisteredToken.find(token_id)

    response = notification_occurence.notify(registered_token)
    notification_occurence.update_progress_status(response, registered_token)
  end
end
