# == Schema Information
#
# Table name: country_institutions
#
#  id             :bigint           not null, primary key
#  country_code   :string           not null
#  institution_id :bigint           not null
#  country_id     :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class CountryInstitution < ApplicationRecord
  attr_accessor :country_name

  belongs_to :institution
  belongs_to :country

  delegate :emoji_flag, :display_name, to: :country
  delegate :name, to: :country, prefix: 'c', allow_nil: true

  after_initialize :set_country

  private

  def set_country
    self.country = Country.create_with(name: self.country_name).find_or_create_by(code: self.country_code.downcase)
  end
end
