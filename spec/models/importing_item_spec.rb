# frozen_string_literal: true

# == Schema Information
#
# Table name: importing_items
#
#  id            :uuid             not null, primary key
#  itemable_id   :uuid
#  itemable_type :string
#  batch_id      :uuid
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "rails_helper"

RSpec.describe ImportingItem, type: :model do
  it { is_expected.to belong_to(:itemable) }
  it { is_expected.to belong_to(:batch) }
end
