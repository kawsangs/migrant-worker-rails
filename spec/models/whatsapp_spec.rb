require 'rails_helper'

RSpec.describe Whatsapp, type: :model do
  subject { build(:whatsapp) }

  it { is_expected.to have_db_column(:value) }
  specify { expect(subject.type).to eq 'Whatsapp' }
end
