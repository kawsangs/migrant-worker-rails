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
#  cancelled_at    :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class NotificationOccurrence < ApplicationRecord
  include NotificationOccurrences::NotifiableConcern

  # Association
  belongs_to :notification, counter_cache: :occurrences_count

  # Validation
  validates :occurrence_date, presence: true

  # Enum
  enum status: {
    pending: 1,
    in_progress: 2,
    delivered: 3,
    cancelled: 4
  }

  # Instance method
  def build_content
    {
      data: {
        payload: {
          form_id: notification.form_id,
          notification_id: notification_id,
          notification_occurrence_id: id
        }.to_json
      }
    }.merge(notification.build_content)
  end

  def mark_as_delivered
    update(status: "delivered")

    notification.increase_delivered_count
  end

  def cancel
    self.update(cancelled_at: Time.zone.now, status: "cancelled")

    delete_sidekiq_job
  end

  private
    def delete_sidekiq_job
      schedule = Sidekiq::ScheduledSet.new.find_job(job_id)
      schedule.try(:delete)
    end
end
