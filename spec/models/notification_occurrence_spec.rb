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
