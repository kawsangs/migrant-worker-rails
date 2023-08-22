# frozen_string_literal: true

require "rails_helper"

class BaseController < Api::V2::ApiController; end

RSpec.describe "Api::V2::ApiController", type: :controller do
  controller(BaseController) do
    def index
      render json: {}, status: 200
    end
  end

  describe "#authenticate_with_token!" do
    let!(:api_key) { ApiKey.create }
    let(:json_response) { JSON.parse(response.body) }

    before :each do
      request.env["HTTP_ACCEPT"] = "application/json"
    end

    context "when no api_key" do
      it "returns 401" do
        get :index
        expect(response.status).to eq(401)
      end
    end

    context "when wrong token" do
      it "returns 401" do
        request.headers["Authorization"] = "Token #{SecureRandom.hex}"
        get :index
        expect(response.status).to eq(401)
      end
    end

    context "when valid api_key" do
      before(:each) do
        request.headers["Authorization"] = "Token #{api_key.access_token}"
        get :index
      end

      it { expect(response.status).to eq(200) }
    end
  end
end
