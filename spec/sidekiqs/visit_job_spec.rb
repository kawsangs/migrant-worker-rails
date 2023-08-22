# frozen_string_literal: true

require "rails_helper"

RSpec.describe VisitJob, type: :job do
  describe "perfom" do
    let!(:user) { create(:user) }
    let(:valid_params) { {
      user_id: user.id, visit_date: Time.now,
      device_id: SecureRandom.hex(8),
      pageable_id: "", pageable_type: "Page",
      page_attributes: { code: "page_one", name_km: "Page one", parent_code: nil }
    }}

    context "new visit" do
      before {
        subject.perform(valid_params.as_json)
      }

      it "create a visit" do
        expect(Visit.count).to eq(1)
      end

      it "create a page" do
        expect(Page.count).to eq(1)
      end
    end

    context "visit again on the same page within 30mn" do
      let!(:page) { create(:page, code: "page_one") }
      let!(:visit) { create(:visit, user: user, page: page, visit_date: (DateTime.now - 5.minute)) }

      before {
        valid_params[:visit_date] = visit.visit_date + 5.minutes
      }

      it "doesn't create a new visit" do
        expect { subject.perform(valid_params.as_json) }.to change { Visit.count }.by 0
      end
    end

    context "visit again on the different page within 30mn" do
      let!(:page) { create(:page, code: "page_zero") }
      let!(:visit) { create(:visit, user: user, page: page, visit_date: (DateTime.now - 5.minute)) }

      before {
        valid_params[:visit_date] = visit.visit_date + 5.minutes
      }

      it "creates a new visit" do
        expect { subject.perform(valid_params.as_json) }.to change { Visit.count }.by 1
      end
    end

    context "visit again on the same page >= 30mn" do
      let!(:page) { create(:page, code: "page_one") }
      let!(:visit) { create(:visit, user: user, page: page, visit_date: (DateTime.now - 30.minute)) }

      before {
        valid_params[:visit_date] = visit.visit_date + 31.minutes
      }

      it "creates a new visit" do
        expect { subject.perform(valid_params.as_json) }.to change { Visit.count }.by 1
      end
    end
  end
end
