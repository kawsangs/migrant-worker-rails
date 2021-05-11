class Institution < ApplicationRecord
  enum kind: { ngo: 1, gov: 2, other: 3 }
  
  # has_many :contacts
  has_many :country_institutions, dependent: :destroy

  accepts_nested_attributes_for :country_institutions, allow_destroy: true

  def country_codes
    country_institutions.map(&:country_code).join(',')
  end
end
