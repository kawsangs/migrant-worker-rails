# frozen_string_literal: true

# == Schema Information
#
# Table name: institutions
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  kind       :integer          default("gov")
#  address    :text             default("")
#  logo       :string
#  audio      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  code       :string
#
class Institution < ApplicationRecord
  enum kind: { ngo: 1, gov: 2, other: 3 }

  has_many :contacts, inverse_of: :institution, dependent: :destroy
  has_many :country_institutions, dependent: :destroy
  has_many :countries, through: :country_institutions

  validates :country_institutions, length: { minimum: 1, message: "should have at least 1 country." }
  validates :name, presence: true

  mount_uploader :logo, ImageUploader
  mount_uploader :audio, AudioUploader

  accepts_nested_attributes_for :country_institutions, allow_destroy: true
  accepts_nested_attributes_for :contacts, reject_if: :all_blank, allow_destroy: true

  def country_names
    countries.map(&:name).join(",")
  end
end
