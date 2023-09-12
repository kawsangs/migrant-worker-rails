# frozen_string_literal: true

# == Schema Information
#
# Table name: forms
#
#  id           :bigint           not null, primary key
#  code         :string
#  name         :string
#  form_type    :string
#  version      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  image        :string
#  audio        :string
#  published_at :datetime
#  description  :text
#
module Forms
  class SurveyForm < ::Form
    # Association
    has_many :notifications, foreign_key: :form_id
    has_many :questions, through: :sections

    # Validation
    validates_associated :sections

    def self.policy_class
      SurveyFormPolicy
    end

    def self.notification_counts
      joins(:notifications)
    end
  end
end
