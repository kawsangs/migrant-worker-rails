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
    let(:notification) { create(:notification, :with_recurrence) }
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

  describe "#after_update, published_survey_form" do
    let!(:releasor) { create(:account) }
    let!(:notification) { create(:notification, :with_survey_form) }
    let!(:survey_form) { notification.survey_form }

    before {
      allow(notification).to receive(:published_survey_form)
    }

    context "notification is released" do
      it "calls method published_survey_form" do
        notification.released_by(releasor.id)

        expect(notification).to have_received(:published_survey_form)
      end
    end

    context "notification is not released" do
      it "calls method published_survey_form" do
        notification.update(title: "test")

        expect(notification).not_to have_received(:published_survey_form)
      end
    end
  end

  describe "#published_survey_form" do
    let!(:survey_form) { create(:survey_form, published_at: nil) }
    let!(:notification) { create(:notification, survey_form: survey_form) }

    it "publishes the form" do
      notification.send(:published_survey_form)

      expect(survey_form.reload.published_at).not_to be_nil
    end
  end
end
