# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::VideosController", type: :request do
  describe "GET #index" do
    let!(:api_key) { ApiKey.create }
    let!(:video)   { create(:video) }
    let(:json_response) { JSON.parse(response.body) }

    before {
      headers = { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" }
      get "/api/v1/videos", headers: headers
    }

    it { expect(response.status).to eq(200) }
    it { expect(json_response["videos"].length).to eq(1) }
  end
end
