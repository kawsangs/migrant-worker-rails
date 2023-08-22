# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V2::VisitsController", type: :request do
  describe "POST #create" do
    let!(:api_key) { create(:api_key) }
    let(:json_response) { JSON.parse(response.body) }
    let(:valid_params) { {
      user_id: SecureRandom.uuid, visit_date: Time.now,
      pageable_id: "", pageable_type: "Page",
      page_attributes: { code: "page_one", name: "Page one", parent_code: nil }
    }}

    before :each do
      headers = { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" }
      post "/api/v2/visits", params: { visit: valid_params }, headers: headers
    end

    it "add a visit job" do
      expect(VisitJob.jobs.count).to eq(1)
    end

    it "render status created" do
      expect(response.status).to eq(201)
    end
  end
end
