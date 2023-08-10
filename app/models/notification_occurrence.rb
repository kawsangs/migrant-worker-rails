# frozen_string_literal: true

# == Schema Information
#
# Table name: notification_occurrences
#
#  id              :uuid             not null, primary key
#  notification_id :integer
#  occurrence_date :datetime
#  token_count     :integer          default(0)
#  success_count   :integer          default(0)
#  failure_count   :integer          default(0)
#  status          :integer          default("pending")
#  job_id          :string
#  cancel_at       :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class NotificationOccurrence < ApplicationRecord
  # Association
  belongs_to :notification, counter_cache: :occurrences_count

  # Validation
  validates :occurrence_date, presence: true

  # Enum
  enum status: {
    pending: 1,
    in_progress: 2,
    delivered: 3
  }

  # Callback
  after_commit :notify_occurence_async, on: [:create]

  # Instance method
  def notify_all_token_async
    self.update(token_count: registered_tokens.length, status: "in_progress")

    registered_tokens.find_each do |token|
      PushNotificationJob.perform_async(id, token.id)
    end
  end

  def notify(registered_token)
    PushNotificationService.new(notification).notify(registered_token.token)
  end

  def update_progress_status(response, registered_token)
    if response[:status_code] == 200
      self.class.increment_counter(:success_count, id)
    else
      self.class.increment_counter(:failure_count, id)

      NotificationLog.create(notification_id: notification_id, registered_token_id: registered_token.id, failed_reason: response[:body])
    end

    mark_as_delivered if self.reload.finished?
  end

  def finished?
    success_count.to_i + failure_count.to_i >= token_count
  end

  private
    def notify_occurence_async
      job_id = NotificationOccurenceJob.perform_at(occurrence_date, id)

      self.update(job_id: job_id)
    end

    def registered_tokens
      @registered_tokens ||= RegisteredToken.all
    end

    def mark_as_delivered
      update(status: "delivered")

      notification.increase_delivered_count
    end
end
