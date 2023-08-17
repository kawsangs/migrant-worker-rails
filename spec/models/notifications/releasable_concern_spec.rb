# frozen_string_literal: true

require "rails_helper"

RSpec.describe Notifications::ReleasableConcern, type: :model do
  describe "#validate check_if_cancellable" do
    context "delivery is completed" do
      let(:notification) { build(:notification, status: :cancelled) }

      it "cannot cancel the notification" do
        allow(notification).to receive(:completed?).and_return(true)
        notification.valid?

        expect(notification.errors.full_messages).to include(I18n.t("notification.cannot_cancell"))
      end
    end

    context "delivery is not completed" do
      let(:notification) { build(:notification, status: :cancelled) }

      it "can cancel the notification" do
        allow(notification).to receive(:completed?).and_return(false)
        notification.valid?

        expect(notification.errors.full_messages).not_to include(I18n.t("notification.cannot_cancell"))
      end
    end
  end

  describe "#after_update, on cancel" do
    let(:notification) { create(:notification) }
    let(:releasor) { create(:account) }

    before {
      notification.released_by(releasor.id)

      allow(notification).to receive(:cancel_pending_notification_occurrence)
    }

    it "calls post_webhook_to_telegram" do
      notification.cancelled_by(releasor.id)

      expect(notification).to have_received(:cancel_pending_notification_occurrence)
    end
  end

  describe "#cancel_pending_notification_occurrence" do
    let(:notification) { create(:notification, :recurrence) }
    let(:releasor) { create(:account) }
    let(:first_occurrence) { notification.notification_occurrences.first }

    before {
      notification.released_by(releasor.id)
      first_occurrence.mark_as_delivered
      notification.cancelled_by(releasor.id)
    }

    it "has 2 notification_occurrences" do
      expect(notification.notification_occurrences.length).to eq(2)
    end

    it "has 1 cancelled notification_occurrence" do
      expect(notification.notification_occurrences.cancelled.length).to eq(1)
    end
  end
end
