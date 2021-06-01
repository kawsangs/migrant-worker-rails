# frozen_string_literal: true

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
require "rails_helper"

RSpec.describe Contact, type: :model do
  it { is_expected.to have_db_column(:type) }
  it { is_expected.to have_db_column(:value) }
  it { is_expected.to belong_to(:institution) }
end
