# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V2::SurveyFormsController", type: :request do
  describe "GET #show" do
    let!(:api_key) { ApiKey.create }
    let!(:form)    { create(:survey_form) }
    let(:json_response) { JSON.parse(response.body) }

    before {
      headers = { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" }
      get "/api/v2/survey_forms/#{form.id}", headers: headers
    }

    it { expect(response.status).to eq(200) }
    it { expect(json_response["id"]).not_to be_nil }
  end
end
