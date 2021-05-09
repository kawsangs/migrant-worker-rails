# frozen_string_literal: true

# == Schema Information
#
# Table name: options
#
#  id            :bigint           not null, primary key
#  question_id   :integer
#  name          :string
#  value         :string
#  score         :integer
#  alert_audio   :string
#  alert_message :text
#  warning       :boolean
#  recursive     :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Option < ApplicationRecord
  mount_uploader :alert_audio, AudioUploader
end
