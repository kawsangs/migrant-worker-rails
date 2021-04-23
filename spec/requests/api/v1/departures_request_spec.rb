# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::CategoriesController", type: :request do
  describe "GET #index" do
    let!(:api_key)  { create(:api_key) }
    let!(:departure_category) { create(:category) }
    let!(:sub_departure) { create(:category, parent_id: departure_category.id) }
    let!(:safety_category) { create(:category, :safety) }
    let!(:headers)  { { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" } }
    let(:body) { JSON.parse(response.body) }

    before {
      get "/api/v1/departures", headers: headers
    }

    it { expect(response.content_type).to eq("application/json; charset=utf-8") }
    it { expect(response.status).to eq(200) }
    it { expect(body.length).to eq(1) }
    it { expect(body.last["name"]).to eq departure_category.name }
  end
end
