require 'rails_helper'

RSpec.describe Country, type: :model do
  it { is_expected.to have_db_column(:name) }
  it { is_expected.to validate_presence_of(:name) }

  describe 'validates' do
    subject { build(:country) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end
end
