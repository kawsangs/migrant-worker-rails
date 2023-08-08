# frozen_string_literal: true

class PushNotificationJob
  include Sidekiq::Job

  def perform(notification_id, token_id)
    notification = Notification.find(notification_id)
    registered_token = RegisteredToken.find(token_id)

    response = notification.notify(registered_token)
    notification.update_progress_status(response, registered_token)
  end
end
