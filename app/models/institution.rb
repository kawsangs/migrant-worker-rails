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
class Institution < ApplicationRecord
  enum kind: { ngo: 1, gov: 2, other: 3 }
  
  has_many :contacts, inverse_of: :institution, dependent: :destroy
  has_many :country_institutions, dependent: :destroy
  has_many :countries, through: :country_institutions
  has_one_attached :logo
  has_one_attached :audio

  accepts_nested_attributes_for :country_institutions, allow_destroy: true
  accepts_nested_attributes_for :contacts, reject_if: :all_blank, allow_destroy: true

  def country_names
    countries.map(&:name).join(',')
  end
end
