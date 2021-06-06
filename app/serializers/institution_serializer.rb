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
class InstitutionSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :kind, :address, :logo_url, :audio_url

  has_many :contacts
  has_many :country_institutions

  def logo_url
    return object.logo_url if object.logo.present?
  end

  def audio_url
    return object.audio_url if object.audio.present?
  end
end
