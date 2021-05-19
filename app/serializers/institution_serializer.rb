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
  attributes :id, :name, :kind

  has_many :contacts
  has_many :country_institutions
end
