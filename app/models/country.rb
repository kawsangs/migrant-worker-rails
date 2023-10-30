# frozen_string_literal: true

# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  code       :string           default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name_km    :string
#
class Country < ApplicationRecord
  has_many :country_institutions
  has_many :institutions, through: :country_institutions
  validates :name, presence: true,
                    uniqueness: { case_sensitive: false }

  # Scope
  scope :query, -> (query) { where("LOWER(name) LIKE ?", "#{query.to_s.downcase}%") }
  scope :exclude_country_all, -> { where.not(code: 'all') }

  delegate :emoji_flag, to: :country_iso, allow_nil: true

  before_save :downcase_code, :capitalize_name

  def country_iso
    ISO3166::Country.find_country_by_alpha2(code)
  end

  def display_name
    name_km || country_iso.try(:local_name) || country_iso.try(:name) || name
  end

  def self.having_institutions
    select("countries.*, count(country_institutions.country_id) as count").joins(:country_institutions).group("countries.id")
  end

  private
    def downcase_code
      self.code = code.downcase
    end

    def capitalize_name
      self.name = name.capitalize
    end
end
