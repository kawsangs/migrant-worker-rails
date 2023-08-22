# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V2::CategoriesController", type: :request do
  describe "GET #index" do
    let!(:api_key)  { create(:api_key) }
    let!(:safety_category) { create(:category, :safety) }
    let!(:sub_safety) { create(:category, parent_id: safety_category.id) }
    let!(:departure_category) { create(:category) }
    let!(:headers)  { { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" } }
    let(:body) { JSON.parse(response.body) }

    before {
      get "/api/v2/safeties", headers: headers
    }

    it { expect(response.content_type).to eq("application/json; charset=utf-8") }
    it { expect(response.status).to eq(200) }
    it { expect(body.length).to eq(1) }
    it { expect(body.last["name"]).to eq safety_category.name }
  end
end
