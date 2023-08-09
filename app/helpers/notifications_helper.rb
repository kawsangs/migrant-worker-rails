# frozen_string_literal: true

module NotificationsHelper
  def description(notification)
    return "" if notification.pending? || notification.delivered?

    "#{I18n.t('notification.success')}: #{notification_count(notification, notification.success_count)}, " +
    "#{I18n.t('notification.failure')}: #{notification_count(notification, notification.failure_count)}"
  rescue
    ""
  end

  def notification_count(notification, count)
    "<strong>#{number_with_delimiter(count)}</strong>"
  end
end
