# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id             :uuid             not null, primary key
#  name           :string
#  taggings_count :integer
#  display_order  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require "rails_helper"

RSpec.describe Tag, type: :model do
  it { is_expected.to have_many(:taggings) }
  it { is_expected.to have_many(:videos).through(:taggings).source(:taggable) }
end
