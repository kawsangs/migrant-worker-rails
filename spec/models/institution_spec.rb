require 'rails_helper'

RSpec.describe Institution, type: :model do
  it { is_expected.to have_db_column(:name) }
  it { is_expected.to have_db_column(:kind) }
  it { is_expected.to have_many(:contacts) }
  it { is_expected.to have_many(:country_institutions) }
end
