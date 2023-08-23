# frozen_string_literal: true

# == Schema Information
#
# Table name: surveys
#
#  id              :bigint           not null, primary key
#  uuid            :string
#  user_uuid       :string
#  form_id         :integer
#  quizzed_at      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  notification_id :integer
#

class Survey < ApplicationRecord
  include Surveys::NotifiableConcern

  # Association
  belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid"
  belongs_to :form
  belongs_to :notification, optional: true
  has_many :survey_answers, foreign_key: :survey_uuid, primary_key: :uuid, dependent: :destroy

  # Nested attribute
  accepts_nested_attributes_for :survey_answers, allow_destroy: true
end
