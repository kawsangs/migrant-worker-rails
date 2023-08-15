# frozen_string_literal: true

require "rails_helper"

RSpec.describe Notifications::SchedulableConcern, type: :model do
  describe "after_commit #create_notification_occurrence" do
    let!(:notification) { create(:notification) }

    before {
      allow(notification).to receive(:occurrence_dates).and_return([1.day.from_now, 2.day.from_now])
    }

    context "release" do
      it "creates notfication_occurrence by the number of occurrence_dates" do
        notification.release!

        expect(notification.occurrences_count).to eq(2)
      end
    end

    context "not release" do
      it "doesn't create notfication_occurrence" do
        notification.update(title: "test")

        expect(notification.occurrences_count).to eq(0)
      end
    end
  end

  describe "#increase_delivered_count" do
    let!(:notification) { create(:notification, occurrences_delivered_count: 0) }

    it "increase occurrences_delivered_count by 1" do
      notification.increase_delivered_count

      expect(notification.reload.occurrences_delivered_count).to eq(1)
    end
  end

  describe "#occurrence_dates" do
    context "as_soon_as_release mode" do
      let(:notification) { build(:notification, schedule_mode: "as_soon_as_release") }

      before {
        @time_now = Time.now

        allow(Time).to receive(:now).and_return(@time_now)
      }

      it "return @time_now" do
        expect(notification.occurrence_dates).to eq([@time_now])
      end
    end

    context "onetime mode" do
      let(:notification) { build(:notification, schedule_mode: "onetime", start_time: Date.tomorrow) }

      it "return notification start_time" do
        expect(notification.occurrence_dates).to eq([notification.start_time])
      end
    end

    context "recurrence mode" do
      let(:notification) { build(:notification, schedule_mode: "recurrence") }

      before {
        @recurrence_dates = [1.day.from_now, 2.day.from_now]

        allow(notification).to receive(:recurrence_dates).and_return(@recurrence_dates)
      }

      it "return @time_now" do
        expect(notification.occurrence_dates).to eq(@recurrence_dates)
      end
    end
  end
end
