# frozen_string_literal: true

require "rails_helper"

RSpec.describe Notifications::SchedulableConcern, type: :model do
  describe "after_commit #create_notification_occurrence" do
    let!(:notification) { create(:notification) }
    let!(:account) { create(:account) }

    before {
      allow(notification).to receive(:occurrence_dates).and_return([1.day.from_now, 2.day.from_now])
    }

    context "release" do
      it "creates notfication_occurrence by the number of occurrence_dates" do
        notification.released_by(account.id)

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

    context "delivery_completed? is true" do
      it "marks notification as completed" do
        allow(notification).to receive(:delivery_completed?).and_return(true)
        notification.increase_delivered_count

        expect(notification.reload.status).to eq("completed")
      end
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

  describe "validates present of #start_time" do
    context "schedule_mode is onetime" do
      let!(:notification) { build(:notification, schedule_mode: "onetime") }

      it "is required" do
        notification.valid?
        expect(notification.errors).to include("start_time")
      end
    end

    context "schedule_mode is not onetime" do
      let!(:notification) { build(:notification, schedule_mode: "recurrence") }

      it "is not required" do
        notification.valid?
        expect(notification.errors).not_to include("start_time")
      end
    end
  end

  describe "validates present of #recurrence_rule" do
    context "schedule_mode is recurrence" do
      let!(:notification) { build(:notification, schedule_mode: "recurrence") }

      it "is required" do
        notification.valid?
        expect(notification.errors).to include("recurrence_rule")
      end
    end

    context "schedule_mode is not recurrence" do
      let!(:notification) { build(:notification, schedule_mode: "onetime") }

      it "is not required" do
        notification.valid?
        expect(notification.errors).not_to include("recurrence_rule")
      end
    end
  end

  describe "validates present of #end_time" do
    context "schedule_mode is recurrence" do
      let!(:notification) { build(:notification, schedule_mode: "recurrence") }

      it "is required" do
        notification.valid?
        expect(notification.errors).to include("end_time")
      end
    end

    context "schedule_mode is not recurrence" do
      let!(:notification) { build(:notification, schedule_mode: "onetime") }

      it "is not required" do
        notification.valid?
        expect(notification.errors).not_to include("end_time")
      end
    end
  end

  describe "#start_time_cannot_be_in_the_past" do
    context "start_time is smaller than current time + 5mn" do
      context "is onetime mode" do
        subject { build(:notification, start_time: Time.zone.now + 4.minutes, schedule_mode: "onetime") }

        it "has error on start_time" do
          subject.valid?
          expect(subject.errors).to include(:start_time)
        end
      end

      context "is not onetime mode" do
        subject { build(:notification, start_time: Time.zone.now + 4.minutes, schedule_mode: "as_soon_as_release") }

        it "has error on start_time" do
          subject.valid?
          expect(subject.errors).not_to include(:start_time)
        end
      end
    end

    context "start_time is bigger than current time + 5mn" do
      subject { build(:notification, start_time: Time.zone.now + 6.minutes, schedule_mode: "onetime") }

      it "doens't have error on start_time" do
        subject.valid?
        expect(subject.errors).not_to include(:start_time)
      end
    end
  end

  describe "#end_time_cannot_be_in_the_past" do
    context "end_time is smaller than today" do
      context "is recurrence mode" do
        subject { build(:notification, end_time: Date.today, schedule_mode: "recurrence") }

        it "has error on end_time" do
          subject.valid?
          expect(subject.errors).to include(:end_time)
        end
      end

      context "is not recurrence mode" do
        subject { build(:notification, end_time: Date.today, schedule_mode: "as_soon_as_release") }

        it "has error on end_time" do
          subject.valid?
          expect(subject.errors).not_to include(:end_time)
        end
      end
    end

    context "end_time is bigger than today" do
      subject { build(:notification, end_time: Date.tomorrow, schedule_mode: "recurrence") }

      it "doens't have error on end_time" do
        subject.valid?
        expect(subject.errors).not_to include(:end_time)
      end
    end
  end
end
