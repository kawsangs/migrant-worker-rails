# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id              :bigint           not null, primary key
#  code            :string
#  name            :text
#  type            :string
#  hint            :string
#  display_order   :integer
#  relevant        :string
#  required        :boolean
#  audio           :string
#  passing_score   :integer
#  passing_message :text
#  passing_audio   :string
#  failing_message :text
#  failing_audio   :string
#  form_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  section_id      :uuid
#
class Question < ApplicationRecord
  include TaggableConcern

  # Mount file
  mount_uploader :audio, AudioUploader
  mount_uploader :passing_audio, AudioUploader
  mount_uploader :failing_audio, AudioUploader

  TYPES = %w[Questions::SelectOne Questions::SelectMultiple Questions::Result Questions::Text Questions::VoiceRecording].freeze

  # Associations
  belongs_to :form, optional: true
  belongs_to :section, optional: true
  has_many   :options, dependent: :destroy
  has_many   :criterias, dependent: :destroy

  # Scope
  default_scope { order(display_order: :asc) }

  # validates :code, presence: true, uniqueness: { scope: :form_id, message: 'already exist' }
  validates :name, presence: true, uniqueness: { scope: :form_id, message: "already exist" }
  validates :type, presence: true, inclusion: { in: TYPES }

  validates :passing_message, presence: true, if: -> { type == "Questions::Result" }
  validates :failing_message, presence: true, if: -> { type == "Questions::Result" }

  before_create :set_display_order
  before_create :set_field_code, if: -> { name.present? }

  # Nested attribute
  accepts_nested_attributes_for :options, allow_destroy: true, reject_if: ->(attributes) { attributes["name"].blank? }
  accepts_nested_attributes_for :criterias, allow_destroy: true

  def self.validation_operators
    ["<", "<=", "=", ">", ">="]
  end

  private
    def set_display_order
      self.display_order ||= form.present? && form.questions.maximum(:display_order).to_i + 1
    end

    def set_field_code
      self.code ||= name.downcase.split(" ").join("_")
    end
end
