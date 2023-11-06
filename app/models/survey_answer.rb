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
class SurveyAnswer < ApplicationRecord
  mount_uploader :voice, AudioUploader

  # Association
  belongs_to :question
  belongs_to :survey, primary_key: "uuid", foreign_key: "survey_uuid", optional: true
  belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid", optional: true

  # Callback
  after_create :notify_telegram_groups

  def notify_telegram_groups
    option = question.options.find_by(value: value)

    if option&.chat_groups.present?
      survey.notify_groups_async(option.chat_groups)
    end
  end

  def display_value
    voice_url || value
  end
end
