require 'rails_helper'

RSpec.describe Phone, type: :model do
  subject { build(:phone) }

  it { is_expected.to have_db_column(:value) }
  specify { expect(subject.type).to eq 'Phone' }
end
