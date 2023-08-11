# frozen_string_literal: true

# == Schema Information
#
# Table name: sections
#
#  id            :uuid             not null, primary key
#  name          :string
#  form_id       :integer
#  display_order :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "rails_helper"

RSpec.describe Section, type: :model do
  it { is_expected.to belong_to(:form) }
  it { is_expected.to have_many(:questions) }
end
