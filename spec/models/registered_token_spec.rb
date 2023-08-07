# frozen_string_literal: true

# == Schema Information
#
# Table name: registered_tokens
#
#  id          :bigint           not null, primary key
#  token       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  device_id   :string
#  device_type :string
#  app_version :string
#
require "rails_helper"

RSpec.describe RegisteredToken, type: :model do
  describe ".from_param" do
    context "old data having no device_id" do
      let!(:registered_token) { create(:registered_token, token: "abc", device_id: nil, device_type: nil, app_version: nil) }
      let!(:params) { { id: registered_token.id, token: "def", device_id: "123", device_type: "mobile", app_version: "0.1.8" } }

      it "returns existing token" do
        expect(RegisteredToken.from_param(params).persisted?).to be_truthy
      end
    end

    context "old data having device_id" do
      let!(:registered_token) { create(:registered_token, token: "abc", device_id: "123", device_type: nil, app_version: nil) }
      let!(:params) { { token: "def", device_id: "123", device_type: "mobile", app_version: "0.1.8" } }

      it "returns existing token" do
        expect(RegisteredToken.from_param(params).persisted?).to be_truthy
      end
    end

    context "new data with device_id" do
      let!(:params) { { token: "def", device_id: "123", device_type: "mobile", app_version: "0.1.8" } }

      it "returns new token" do
        expect(RegisteredToken.from_param(params).new_record?).to be_truthy
      end
    end

    context "new data with id" do
      let!(:params) { { id: 1, token: "def", device_id: "123", device_type: "mobile", app_version: "0.1.8" } }

      it "returns new token" do
        expect(RegisteredToken.from_param(params).new_record?).to be_truthy
      end
    end
  end
end
