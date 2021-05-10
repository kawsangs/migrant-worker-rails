require 'rails_helper'

RSpec.describe HelpCenter, type: :model do
  it { is_expected.to have_db_column(:name) }
  it { is_expected.to validate_presence_of(:name) }

  describe 'validates' do
    subject { build(:help_center) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end
end
