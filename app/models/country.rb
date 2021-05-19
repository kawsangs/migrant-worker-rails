# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  code       :string           default("")
#
class Country < ApplicationRecord
  has_many :country_institutions
  has_many :institutions, through: :country_institutions
  validates :name, presence: true,
                    uniqueness: { case_sensitive: false }

  scope :query, -> (query) { where('LOWER(name) LIKE ?', "#{query.to_s.downcase}%") }

  delegate :emoji_flag, to: :country_iso

  def country_iso
    ISO3166::Country.find_country_by_name(name)
  end
end
