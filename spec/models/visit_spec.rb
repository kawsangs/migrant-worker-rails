# frozen_string_literal: true

# == Schema Information
#
# Table name: visits
#
#  id            :uuid             not null, primary key
#  page_id       :string
#  pageable_id   :string
#  pageable_type :string
#  device_id     :string
#  visit_date    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_uuid     :string
#
require "rails_helper"

RSpec.describe Visit, type: :model do
  it { is_expected.to belong_to(:user).with_foreign_key(:user_uuid).with_primary_key(:uuid).optional(true) }
  it { is_expected.to belong_to(:page) }
  it { is_expected.to belong_to(:pageable).optional(true) }
  it { is_expected.to belong_to(:device).with_foreign_key(:device_id).with_primary_key(:device_id).class_name("RegisteredToken").optional(true) }

  describe "page_attributes=" do
    context "new page" do
      let(:page_attr) { { code: "page_one", name_km: "Page one", parent_code: nil } }
      let(:visit) { build(:visit) }

      it "create a new page" do
        expect { visit.page_attributes=(page_attr) }.to change { Page.count }.by 1
      end
    end

    context "existing page" do
      let!(:page) { create(:page, code: "page_one", name_km: "Page one") }
      let(:page_attr) { { code: "page_one", name_km: "Page one", parent_code: nil } }
      let(:visit) { build(:visit) }

      it "use existing page" do
        expect { visit.page_attributes=(page_attr) }.to change { Page.count }.by 0
      end
    end

    context "parent page exist" do
      let!(:page) { create(:page, code: "page_one", name_km: "Page one") }
      let(:page_attr) { { code: "page_two", name_km: "Page two", parent_code: page.code } }
      let(:visit) { build(:visit) }

      it "create a new page" do
        expect { visit.page_attributes=(page_attr) }.to change { Page.count }.by 1
      end
    end

    context "parent_id page not exist" do
      let(:page_attr) { { code: "page_two", name_km: "Page two", parent_code: "page_one" } }
      let(:visit) { build(:visit) }

      it "create 2 new pages" do
        expect { visit.page_attributes=(page_attr) }.to change { Page.count }.by 2
      end
    end

    context "Video detail page with pageable_id and pageable_type" do
      let!(:video) { create(:video) }
      let!(:page_attr) { { code: "video_detail", name: "Video detail", parent_code: "" } }
      let!(:visit) { create(:visit, pageable_id: video.id, pageable_type: "Video", page_attributes: page_attr) }

      it "assigns pageable to video" do
        expect(visit.pageable).to eq video
      end
    end

    context "Video page without pageable_id and pageable_type" do
      let!(:page_attr) { { code: "video", name: "Video", parent_code: "" } }
      let!(:visit) { create(:visit, pageable_id: "", pageable_type: "", page_attributes: page_attr) }

      it "assigns pageable to video" do
        expect(visit.pageable).to eq visit.page
      end
    end
  end

  describe "#last_visit" do
    let!(:user) { create(:user) }
    let(:valid_params) { {
      user_uuid: user.uuid, visit_date: Time.now,
      page_attributes: { code: "page_one", name_km: "Page one", parent_code: nil },
    }}

    subject { described_class.new(valid_params) }

    context "first visit" do
      it "returns nil" do
        expect(subject.last_visit).to be_nil
      end
    end

    context "second visit with visit_date within 30mn" do
      context "on the same page" do
        let!(:page)  { create(:page, code: "page_one") }
        let!(:visit) { create(:visit, user: user, page: page, visit_date: (DateTime.now - 5.minute)) }

        before {
          subject.visit_date = visit.visit_date + 5.minutes
        }

        it "returns 1 object" do
          expect(subject.last_visit).not_to be_nil
        end
      end

      context "different page" do
        let!(:page)  { create(:page, code: "page_zero") }
        let!(:visit) { create(:visit, user: user, page: page, visit_date: (DateTime.now - 25.minute)) }

        before {
          subject.visit_date = visit.visit_date + 25.minutes
        }

        it "returns nil" do
          expect(subject.last_visit).to be_nil
        end
      end
    end

    context "second visit with visit_date >= 30mn" do
      context "on the same page" do
        let!(:page) { create(:page, code: "page_one") }
        let!(:visit) { create(:visit, user: user, page: page, visit_date: (DateTime.now - 30.minute)) }

        before {
          subject.visit_date = visit.visit_date + 31.minutes
        }

        it "returns nil" do
          expect(subject.last_visit).to be_nil
        end
      end

      context "different page" do
        let!(:page) { create(:page, code: "page_zero") }
        let!(:visit) { create(:visit, user: user, page: page, visit_date: (DateTime.now - 30.minute)) }

        before {
          subject.visit_date = visit.visit_date + 31.minutes
        }

        it "returns nil" do
          expect(subject.last_visit).to be_nil
        end
      end
    end
  end
end
