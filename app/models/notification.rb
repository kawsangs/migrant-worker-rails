# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id            :bigint           not null, primary key
#  title         :string
#  body          :text
#  success_count :integer
#  failure_count :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  published_at  :datetime
#  status        :integer          default("draft")
#
class Notification < ApplicationRecord
  # Enum
  enum status: {
    draft: 0,
    pending: 1,
    delivered: 2
  }

  # Validation
  validates :title, presence: true
  validates :body, presence: true

  # Association
  has_many :notification_logs

  # Callback
  after_commit :push_notification_async, on: [:update, :create]

  # Instant method
  def build_content
    { notification: { title: title, body: body } }
  end

  def published?
    published_at.present?
  end

  def publish!
    self.update!(published_at: Time.zone.now, status: "pending")
  end

  private
    def push_notification_async
      PushNotificationJob.perform_async(id) if published?
    end
end
