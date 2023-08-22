# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::InstitutionsController, type: :request do
  describe "GET :index" do
    let(:api_key) { ApiKey.create! }
    let(:headers) { { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" } }
    let(:json_response) { JSON.parse(response.body) }
    let!(:institution) { create(:institution, :with_country) }
    let!(:country) { institution.countries.first }

    before(:each) do
      get "/api/v2/countries/#{country.code}/institutions", headers: headers
    end

    it { expect(response.status).to eq(200) }
    it { expect(json_response.first["id"]).not_to be_nil }
  end
end
