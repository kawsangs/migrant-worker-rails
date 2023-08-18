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
#  releasor_id                 :integer
#  cancelled_at                :datetime
#  canceller_id                :integer
#
class Notification < ApplicationRecord
  include Notifications::SchedulableConcern
  include Notifications::ReleasableConcern

  # Enum
  enum status: {
    draft: 0,
    released: 1,
    cancelled: 2
  }

  # Validation
  validates :title, presence: true
  validates :body, presence: true

  # Association
  belongs_to :survey_form, foreign_key: :form_id, class_name: "Forms::SurveyForm", optional: true
  belongs_to :releasor, class_name: "Account", optional: true
  belongs_to :canceller, class_name: "Account", optional: true
  has_many :notification_logs
  has_many :notification_occurrences, dependent: :destroy

  # Delegation
  delegate :name, to: :survey_form, prefix: true, allow_nil: true

  # Scope
  default_scope { order(created_at: :desc) }

  # Instant method
  def build_content
    {
      notification: { title: title, body: body },
      data: { payload: { data: { form_id: form_id } }.to_json }
    }
  end

  def completed?
    occurrences_count.positive? && occurrences_delivered_count == occurrences_count
  end
end
