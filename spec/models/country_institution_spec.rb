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
require 'rails_helper'

RSpec.describe CountryInstitution, type: :model do
  it { is_expected.to have_db_column(:country_code) }
  it { is_expected.to belong_to(:institution) }
end
