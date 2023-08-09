# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id              :bigint           not null, primary key
#  title           :string
#  body            :text
#  success_count   :integer
#  failure_count   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  published_at    :datetime
#  status          :integer          default("draft")
#  form_id         :integer
#  token_count     :integer          default(0)
#  schedule_mode   :integer          default("as_soon_as_release")
#  recurrence_rule :string
#  start_time      :datetime
#  end_time        :datetime
#
class Notification < ApplicationRecord
  include Notifications::NotifiableConcern

  # Enum
  enum status: {
    draft: 0,
    pending: 1,
    delivered: 2
  }

  enum schedule_mode: {
    as_soon_as_release: 0,
    onetime: 1,
    recurrence: 2
  }

  # Validation
  validates :title, presence: true
  validates :body, presence: true
  validates :start_time, presence: true, if: -> { onetime? }
  validates :recurrence_rule, presence: true, if: -> { recurrence? }
  validates :end_time, presence: true, if: -> { recurrence? }

  # Association
  belongs_to :survey_form, foreign_key: :form_id, class_name: "Forms::SurveyForm", optional: true
  has_many :notification_logs

  # Delegation
  delegate :name, to: :survey_form, prefix: true, allow_nil: true

  # Instant method
  def build_content
    {
      notification: { title: title, body: body },
      data: { payload: { data: { form_id: form_id } }.to_json }
    }
  end

  def published?
    published_at.present?
  end

  def publish!
    self.update!(published_at: Time.zone.now, status: "pending")
  end

  def display_schedule
    return I18n.t("notification.as_soon_as_release") if as_soon_as_release?
    return I18n.l(start_time) if onetime?

    RecurringSelect.dirty_hash_to_rule(recurrence_rule)
  end

  # Class method
  def self.schedule_mode_list
    [
      [I18n.t("notification.as_soon_as_release"), "as_soon_as_release"],
      [I18n.t("notification.onetime"), "onetime"],
      [I18n.t("notification.recurrence"), "recurrence"],
    ]
  end
end
