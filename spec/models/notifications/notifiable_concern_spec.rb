# frozen_string_literal: true

require "rails_helper"

RSpec.describe Notifications::NotifiableConcern, type: :model do
  describe "#update_progress_status" do
    let!(:notification) { create(:notification, success_count: 0, failure_count: 0, token_count: 1) }
    let!(:registered_token) { create(:registered_token) }

    context "response success" do
      before {
        notification.update_progress_status({ status_code: 200 }, registered_token)
      }

      it "increases success_count" do
        expect(notification.success_count).to eq(1)
      end

      it "set status delivered" do
        expect(notification.status).to eq("delivered")
      end
    end

    context "response failure" do
      it "increases failure_count" do
        notification.update_progress_status({ status_code: 400, body: "The registration token is not a valid FCM registration token" }, registered_token)

        expect(notification.failure_count).to eq(1)
      end
    end
  end

  describe "#notify_all" do
    let!(:notification) { create(:notification, success_count: 0, failure_count: 0, token_count: 0) }
    let!(:registered_token) { create(:registered_token) }

    before {
      notification.notify_all
    }

    it "updates notification token_count" do
      expect(notification.token_count).to eq(1)
    end

    it "add job to sidekiq" do
      expect(PushNotificationJob.jobs.size).to eq(1)
    end
  end

  describe "#finished?" do
    it "returns true" do
      notification = build(:notification, success_count: 10, failure_count: 5, token_count: 15)
      expect(notification.finished?).to be_truthy
    end

    it "returns false" do
      notification = build(:notification, success_count: 1, failure_count: 5, token_count: 15)
      expect(notification.finished?).to be_falsey
    end
  end
end
