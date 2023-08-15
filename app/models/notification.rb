# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id                          :bigint           not null, primary key
#  title                       :string
#  body                        :text
#  success_count               :integer
#  failure_count               :integer
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  released_at                 :datetime
#  status                      :integer          default("draft")
#  form_id                     :integer
#  token_count                 :integer          default(0)
#  schedule_mode               :integer          default("as_soon_as_release")
#  recurrence_rule             :string
#  start_time                  :datetime
#  end_time                    :datetime
#  occurrences_count           :integer          default(0)
#  occurrences_delivered_count :integer          default(0)
#
class Notification < ApplicationRecord
  include Notifications::SchedulableConcern

  # Enum
  enum status: {
    draft: 0,
    released: 1
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

  validate  :start_time_cannot_be_in_the_past, if: -> { onetime? }
  validate  :end_time_must_be_at_lease_tomorrow, if: -> { recurrence? }

  # Association
  belongs_to :survey_form, foreign_key: :form_id, class_name: "Forms::SurveyForm", optional: true
  has_many :notification_logs
  has_many :notification_occurrences

  # Delegation
  delegate :name, to: :survey_form, prefix: true, allow_nil: true

  # Instant method
  def build_content
    {
      notification: { title: title, body: body },
      data: { payload: { data: { form_id: form_id } }.to_json }
    }
  end

  def release!
    self.update!(released_at: Time.zone.now, status: "released")
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
      [I18n.t("notification.recurrence"), "recurrence"]
    ]
  end

  private
    def start_time_cannot_be_in_the_past
      if start_time.present? && start_time < Time.zone.now + 5.minutes
        errors.add(:start_time, "must be bigger than current time at least 5 minutes")
      end
    end

    def end_time_must_be_at_lease_tomorrow
      if end_time.present? && end_time < Date.tomorrow.in_time_zone("Bangkok")
        errors.add(:end_time, "must be bigger than today")
      end
    end
end
