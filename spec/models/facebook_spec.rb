# == Schema Information
#
# Table name: contacts
#
#  id             :bigint           not null, primary key
#  type           :string           not null
#  value          :string           default("")
#  institution_id :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe Facebook, type: :model do
  subject { build(:facebook) }

  it { is_expected.to have_db_column(:value) }
  specify { expect(subject.type).to eq 'Facebook' }
end
