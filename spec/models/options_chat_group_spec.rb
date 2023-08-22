# frozen_string_literal: true

# == Schema Information
#
# Table name: options_chat_groups
#
#  id            :uuid             not null, primary key
#  option_id     :integer
#  chat_group_id :uuid
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "rails_helper"

RSpec.describe OptionsChatGroup, type: :model do
  it { is_expected.to belong_to(:option) }
  it { is_expected.to belong_to(:chat_group) }
end
