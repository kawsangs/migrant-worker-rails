require 'rails_helper'

RSpec.describe Contact, type: :model do
  it { is_expected.to have_db_column(:type) }
  it { is_expected.to have_db_column(:value) }
  it { is_expected.to belong_to(:institution) }
end
