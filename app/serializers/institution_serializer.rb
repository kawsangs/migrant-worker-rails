# == Schema Information
#
# Table name: institutions
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  kind       :integer          default("gov")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class InstitutionSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :kind, :address, :logo_url, :audio_url

  has_many :contacts
  has_many :country_institutions

  def logo_url
    return nil unless object.logo.attached?
    object.logo.filename.to_s
  end

  def audio_url
    return nil unless object.audio.attached?
    object.audio.filename.to_s
  end
end
