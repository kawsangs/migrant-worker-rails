# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :request do
  describe "POST user#create" do
    let(:api_key) { ApiKey.create }
    let(:headers) { { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" } }
    let(:params) {
      { "user"=>'{"uuid":"a86239a8-f8b2-4702-9590-dd15a189d40d","full_name":"Sokra","age":"30","sex":"female","phone_number":"012 333 444","voice":""}' }
    }

    it "create a new user" do
      expect {
        post "/api/v2/users", headers: headers, params: params
      }.to change(User, :count).by(1)
    end
  end
end
