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

  attributes :id, :name, :kind, :address, :logo_url

  has_many :contacts
  has_many :country_institutions

  def logo_url
    return nil unless object.logo.attached?

    variant = object.logo.variant(resize_to_limit: [100, 100])
    rails_representation_url(variant, only_path: true)
  end
end
