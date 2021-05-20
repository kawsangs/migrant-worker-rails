# == Schema Information
#
# Table name: country_institutions
#
#  id             :bigint           not null, primary key
#  country_name   :string           not null
#  institution_id :bigint           not null
#  country_id     :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class CountryInstitution < ApplicationRecord
  belongs_to :institution
  belongs_to :country

  delegate :emoji_flag, to: :country

  after_initialize :set_country

  private

  def set_country
    self.country = Country.find_or_create_by(name: self.country_name)
  end
end
