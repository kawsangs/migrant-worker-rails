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
FactoryBot.define do
  factory :notification do
    title { FFaker::Name.name }
    body  { FFaker::Name.name }

    trait :with_recurrence do
      schedule_mode   { "recurrence" }
      recurrence_rule { "{\"validations\":{\"day\":[1]},\"rule_type\":\"IceCube::WeeklyRule\",\"interval\":1,\"week_start\":0}" }
      end_time { 2.weeks.from_now - 1.day }
    end

    trait :with_survey_form do
      survey_form { create(:survey_form) }
    end
  end
end
