# frozen_string_literal: true

require "rails_helper"

RSpec.describe PushNotificationService do
  describe "#notify" do
    let!(:registered_token) { create(:registered_token) }
    let!(:notification)     { create(:notification) }

    let(:service) { described_class.new(notification) }

    context "success" do
      before {
        allow(service).to receive_message_chain(:fcm, :send_v1).and_return({ status_code: 200 })
      }

      it "gives detail success: + 1" do
        service.notify(registered_token)

        expect(service.success_count).to eq(1)
        expect(service.failure_count).to eq(0)
      end
    end

    context "failure" do
      before {
        allow(service).to receive_message_chain(:fcm, :send_v1).and_return({ status_code: 404 })
      }

      it "gives detail failure: + 1" do
        service.notify(registered_token)

        expect(service.success_count).to eq(0)
        expect(service.failure_count).to eq(1)
      end
    end
  end
end
