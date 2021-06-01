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
#
class InstitutionSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :kind, :address, :logo_url, :logo, :audio_url

  has_many :contacts
  has_many :country_institutions

  def logo
    "require('../../../app/assets/images/dummy/#{logo_url}')" if logo_url.present?
  end

  def logo_url
    return unless object.logo.file.present?
    object.logo.url
  end

  def audio_url
    return nil unless object.audio.file.present?
    object.audio.identifier
  end
end
