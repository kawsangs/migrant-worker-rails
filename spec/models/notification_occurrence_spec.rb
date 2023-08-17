# frozen_string_literal: true

# == Schema Information
#
# Table name: notification_occurrences
#
#  id              :uuid             not null, primary key
#  notification_id :integer
#  occurrence_date :datetime
#  token_count     :integer          default(0)
#  success_count   :integer          default(0)
#  failure_count   :integer          default(0)
#  status          :integer          default("pending")
#  job_id          :string
#  cancelled_at    :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require "rails_helper"

RSpec.describe NotificationOccurrence, type: :model do
  it { is_expected.to belong_to(:notification) }
  it { is_expected.to validate_presence_of(:occurrence_date) }

  describe "#counter_cache" do
    let!(:notification) { create(:notification) }

    it "increases notification occurrences_count by 1" do
      create(:notification_occurrence, notification_id: notification.id)
      expect(notification.reload.occurrences_count).to eq(1)
    end
  end

  describe "#update_progress_status" do
    let!(:notification_occurrence) { create(:notification_occurrence, success_count: 0, failure_count: 0, token_count: 1) }
    let!(:registered_token) { create(:registered_token) }

    context "response success" do
      before {
        notification_occurrence.update_progress_status({ status_code: 200 }, registered_token)
      }

      it "increases success_count" do
        expect(notification_occurrence.success_count).to eq(1)
      end

      it "set status delivered" do
        expect(notification_occurrence.status).to eq("delivered")
      end
    end

    context "response failure" do
      it "increases failure_count" do
        notification_occurrence.update_progress_status({ status_code: 400, body: "The registration token is not a valid FCM registration token" }, registered_token)

        expect(notification_occurrence.failure_count).to eq(1)
      end
    end
  end

  describe "#notify_all_token_async" do
    let!(:notification_occurrence) { create(:notification_occurrence, success_count: 0, failure_count: 0, token_count: 0) }
    let!(:registered_token) { create(:registered_token) }

    before {
      notification_occurrence.notify_all_token_async
    }

    it "updates notification_occurrence token_count" do
      expect(notification_occurrence.token_count).to eq(1)
    end

    it "add job to sidekiq" do
      expect(PushNotificationJob.jobs.size).to eq(1)
    end
  end

  describe "#finished?" do
    it "returns true" do
      notification_occurrence = build(:notification_occurrence, success_count: 10, failure_count: 5, token_count: 15)
      expect(notification_occurrence.finished?).to be_truthy
    end

    it "returns false" do
      notification_occurrence = build(:notification_occurrence, success_count: 1, failure_count: 5, token_count: 15)
      expect(notification_occurrence.finished?).to be_falsey
    end
  end

  describe "#cancel" do
    let(:notification_occurrence) { create(:notification_occurrence, occurrence_date: 2.days.from_now) }

    it "updates status to cancelled" do
      expect { notification_occurrence.cancel }.to change(notification_occurrence, :status).to("cancelled")
    end

    it "delete job from sidekiq" do
      allow(notification_occurrence).to receive(:delete_sidekiq_job)
      notification_occurrence.cancel

      expect(notification_occurrence).to have_received(:delete_sidekiq_job)
    end
  end
end
