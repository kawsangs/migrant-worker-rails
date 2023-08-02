# frozen_string_literal: true

# == Schema Information
#
# Table name: video_authors
#
#  id            :uuid             not null, primary key
#  name          :string
#  videos_count  :integer          default(0)
#  display_order :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "rails_helper"

RSpec.describe VideoAuthor, type: :model do
  it { is_expected.to have_many(:videos) }

  describe "counter cache" do
    let(:video_author) { create(:video_author) }

    it "has a videos counter cache" do
      expect {
        create(:video, video_author: video_author)
      }.to change { video_author.videos_count }.by(1)
    end
  end
end
