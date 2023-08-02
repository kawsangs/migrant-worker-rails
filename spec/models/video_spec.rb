# frozen_string_literal: true

# == Schema Information
#
# Table name: videos
#
#  id              :uuid             not null, primary key
#  name            :string
#  description     :text
#  url             :string
#  display_order   :integer
#  video_author_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require "rails_helper"

RSpec.describe Video, type: :model do
  it { is_expected.to belong_to(:video_author).optional }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:url) }
end
