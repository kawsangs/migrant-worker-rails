require 'rails_helper'

RSpec.describe Api::V1::MigrantsController, type: :controller do
  describe "POST migrant#create" do
    let(:api_key) { ApiKey.create! }
    let(:attributes) {
      {"migrant"=>"{\"uuid\":\"a86239a8-f8b2-4702-9590-dd15a189d40d\",\"full_name\":\"Sokra\",\"age\":\"30\",\"sex\":\"female\",\"phone_number\":\"012 333 444\",\"voice\":\"\"}"}
    }

    context "success" do
      before(:each) do
        request.headers['Authorization'] = "Token #{api_key.access_token}"
      end

      it "create a new migrant" do
        expect { post :create, { params: attributes } }.to change(Migrant, :count).by(1)
      end
    end

    context "fail" do
      it "do not create a new migrant" do
        expect { post :create, { params: attributes } }.to change(Migrant, :count).by(0)
      end
    end
  end
end
