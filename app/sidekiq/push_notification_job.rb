# frozen_string_literal: true

class PushNotificationJob
  include Sidekiq::Job

  def perform(notification_id)
    notification = Notification.find_by(id: notification_id)

    res = PushNotificationService.new(notification).notify_all(RegisteredToken.all)

    notification.update_columns(
      success_count: res[:success_count],
      failure_count: res[:failure_count],
      status: "delivered"
    )
  end
end
