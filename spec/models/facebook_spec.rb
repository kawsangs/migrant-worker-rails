require 'rails_helper'

RSpec.describe Facebook, type: :model do
  subject { build(:facebook) }

  it { is_expected.to have_db_column(:value) }
  specify { expect(subject.type).to eq 'Facebook' }
end
