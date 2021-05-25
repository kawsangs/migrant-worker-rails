require 'rails_helper'

RSpec.describe Api::V1::CountriesController, type: :controller do
  describe 'GET :index' do
    let(:api_key) { ApiKey.create! }

    before(:each) do
      request.headers["Authorization"] = "Token #{api_key.access_token}"
    end

    it "returns json" do
      get :index

      expect(response.content_type).to include 'application/json'
    end
  end
end
