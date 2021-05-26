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
  mount_uploader :image, ImageUploader

  # Validation
  validates :value, :name, presence: true, uniqueness: { scope: [:question_id] }
  before_validation :set_option_value, if: -> { name.present? }

  private
    def set_option_value
      self.value = (value.presence || name).downcase.split(' ').join('_')
    end
end
