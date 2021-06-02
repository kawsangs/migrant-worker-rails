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
#
class Notification < ApplicationRecord
  validates :body, presence: true

  after_commit :push_notification_async, on: [:create]

  def push_notification_async
    NotificationWorker.perform_async(id)
  end

  def build_content
    { notification: { title: title, body: body } }
  end
end
