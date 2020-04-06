require 'rails_helper'

RSpec.describe Api::V1::MigrantsController, type: :controller do
  describe "POST migrant#create" do
    let(:api_key) { ApiKey.create! }
    let(:attributes) {
      {
        migrant: {
          full_name: 'Nary',
          sex: 'F',
          age: '30',
          voice: ''
        }
      }
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
