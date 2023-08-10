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
FactoryBot.define do
  factory :notification_occurrence do
    occurrence_date { rand(1..7).days.from_now }
    notification
  end
end
