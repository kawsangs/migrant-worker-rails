# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V2::RegisteredTokensController", type: :request do
  describe "PUT #update" do
    let(:api_key) { create(:api_key) }
    let(:headers) { { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" } }
    let(:json_response) { JSON.parse(response.body) }

    context "new device_id" do
      let(:params) { { token: "abcd", device_id: "a1b2", device_type: "mobile", app_version: "1.0.1" } }

      it "creates a registered_token" do
        expect {
          put "/api/v2/registered_tokens", params: { registered_token: params }, headers: headers
        }.to change { RegisteredToken.count }.by(1)
      end
    end

    context "existing device_id" do
      let!(:registered_token) { create(:registered_token, token: "aaaa", device_id: "a1b2") }
      let!(:params) { { token: "abcdefg", device_id: "a1b2", device_type: "mobile", app_version: "1.0.1" } }

      it "doesn't creates a registered_token" do
        expect {
          put "/api/v2/registered_tokens", params: { registered_token: params }, headers: headers
        }.to change { RegisteredToken.count }.by (0)
      end

      it "update the registered_token" do
        expect {
          put "/api/v2/registered_tokens", params: { registered_token: params }, headers: headers
        }.to change { registered_token.reload.token }.from("aaaa").to("abcdefg")
      end
    end
  end
end
