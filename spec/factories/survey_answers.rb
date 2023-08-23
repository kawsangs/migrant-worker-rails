# frozen_string_literal: true

# == Schema Information
#
# Table name: survey_answers
#
#  id            :bigint           not null, primary key
#  uuid          :string
#  question_id   :integer
#  question_code :string
#  value         :string
#  score         :integer
#  user_uuid     :string
#  survey_uuid   :string
#  voice         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :survey_answer do
  end
end
