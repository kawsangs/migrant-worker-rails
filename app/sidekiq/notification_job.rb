# frozen_string_literal: true

class NotificationJob
  include Sidekiq::Job

  def perform(notification_id)
    notification = Notification.find(notification_id)
    notification.notify_all
  end
end
