# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::CountryInstitutionsController, type: :controller do
  describe "GET :index" do
    let(:api_key) { ApiKey.create! }
    let(:country) { create(:country) }

    before(:each) do
      request.headers["Authorization"] = "Token #{api_key.access_token}"
    end

    it "returns json" do
      get :index, params: { country_id: country.id }

      expect(response.content_type).to include "application/json"
    end
  end
end
