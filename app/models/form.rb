# frozen_string_literal: true

# == Schema Information
#
# Table name: forms
#
#  id         :bigint           not null, primary key
#  uuid       :string
#  name       :string
#  form_type  :string
#  version    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Form < ApplicationRecord
  mount_uploader :audio, AudioUploader
  mount_uploader :image, ImageUploader

  has_many :questions, dependent: :destroy

  accepts_nested_attributes_for :questions, allow_destroy: true
end
