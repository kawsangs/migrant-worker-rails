class CountryInstitution < ApplicationRecord
  belongs_to :institution
  belongs_to :country

  delegate :emoji_flag, to: :country_iso

  after_initialize :set_country
  
  private

  def set_country
    self.country = Country.find_or_create_by(name: self.country_code)
  end

  def country_iso
    ISO3166::Country.find_country_by_name(country_code)
  end
end
