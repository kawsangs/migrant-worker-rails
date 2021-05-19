# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  code       :string           default("")
#
require 'rails_helper'

RSpec.describe Country, type: :model do
  it { is_expected.to have_db_column(:name) }
  it { is_expected.to validate_presence_of(:name) }

  describe 'validates' do
    subject { build(:country) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end
end
