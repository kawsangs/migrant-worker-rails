class CountryInstitution < ApplicationRecord
  belongs_to :institution

  delegate :emoji_flag, to: :country
  
  private

  def country
    ISO3166::Country.find_country_by_name(self.country_code)
  end
end
