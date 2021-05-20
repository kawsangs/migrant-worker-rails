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
class CountryInstitutionSerializer < ActiveModel::Serializer
  attributes :country_id
  
  belongs_to :institution
end
