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
#
require "rails_helper"

RSpec.describe Notification, type: :model do
  it { is_expected.to belong_to(:survey_form).class_name("Forms::SurveyForm").with_foreign_key(:form_id).optional }
  it { is_expected.to belong_to(:releasor).class_name("Account").optional }
  it { is_expected.to have_many(:notification_logs) }
  it { is_expected.to have_many(:notification_occurrences) }
end
