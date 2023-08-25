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
class Form < ApplicationRecord
  include TaggableConcern

  self.inheritance_column = :form_type

  # Mount file
  mount_uploader :audio, AudioUploader
  mount_uploader :image, ImageUploader

  # Association
  has_many :questions, inverse_of: :form
  has_many :surveys
  has_many :sections, dependent: :destroy, inverse_of: :form

  # Validation
  validates :name, presence: true

  # Scope
  default_scope { order("created_at desc") }
  scope :published, -> { where.not(published_at: nil) }

  # Nested attribute
  accepts_nested_attributes_for :questions, allow_destroy: true
  accepts_nested_attributes_for :sections, allow_destroy: true

  # Callback
  before_create :secure_code

  def published?
    published_at.present?
  end

  def status
    published? ? "published" : "draft"
  end

  def publish
    update(published_at: Time.now)
  end
end
