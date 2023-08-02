# frozen_string_literal: true

# == Schema Information
#
# Table name: batches
#
#  id             :uuid             not null, primary key
#  code           :string
#  total_count    :integer          default(0)
#  valid_count    :integer          default(0)
#  new_count      :integer          default(0)
#  province_count :integer          default(0)
#  reference      :string
#  creator_id     :integer
#  type           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require "rails_helper"

RSpec.describe Batch, type: :model do
  it { is_expected.to have_many(:importing_items) }

  context "accepting nested importing_items with itemable video" do
    let(:account) { create(:account) }
    let(:param) {
      {
        total_count: 1,
        valid_count: 1,
        new_count: 1,
        province_count: 0,
        reference: nil,
        creator_id: account.id,
        type: "Batches::VideoBatch",
        importing_items_attributes: [{
          itemable_id: "", itemable_type: "Video",
          itemable_attributes: {
            id: "", name: "Video title", url: "http://example.com", video_author_attributes: { name: "ABC" }
          }
        }]
      }
    }

    describe "#create" do
      before { @batch = Batch.create(param) }

      it "create successfully" do
        expect(@batch.valid?).to be_truthy
      end

      it "create video" do
        expect(@batch.importing_items.length).to eq(1)
        expect(@batch.videos.length).to eq(1)
      end
    end

    describe "#update itemable" do
      let(:batch1) { Batch.create(param) }
      let(:param2) {
        {
          total_count: 1,
          valid_count: 1,
          new_count: 1,
          province_count: 0,
          reference: nil,
          creator_id: account.id,
          type: "Batches::VideoBatch",
          importing_items_attributes: [{
            itemable_id: batch1.videos.last.id, itemable_type: "Video",
            itemable_attributes: {
              id: batch1.videos.last.id, name: "Video title2", url: "http://example.com", video_author_attributes: { name: "ABC" }
            }
          }]
        }
      }

      before {
        @batch2 = Batch.create(param2)
      }

      it "updates video" do
        expect(Batch.count).to eq(2)
        expect(Video.count).to eq(1)
        expect(@batch2.videos.first.name).to eq("Video title2")
      end
    end
  end
end
