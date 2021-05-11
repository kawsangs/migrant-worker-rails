require 'rails_helper'

RSpec.describe CountryInstitution, type: :model do
  it { is_expected.to have_db_column(:country_code) }
  it { is_expected.to belong_to(:institution) }
end
