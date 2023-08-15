# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id                          :bigint           not null, primary key
#  title                       :string
#  body                        :text
#  success_count               :integer
#  failure_count               :integer
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  released_at                 :datetime
#  status                      :integer          default("draft")
#  form_id                     :integer
#  token_count                 :integer          default(0)
#  schedule_mode               :integer          default("as_soon_as_release")
#  recurrence_rule             :string
#  start_time                  :datetime
#  end_time                    :datetime
#  occurrences_count           :integer          default(0)
#  occurrences_delivered_count :integer          default(0)
#
require "rails_helper"

RSpec.describe Notification, type: :model do
  it { is_expected.to belong_to(:survey_form).class_name("Forms::SurveyForm").with_foreign_key(:form_id).optional }
  it { is_expected.to have_many(:notification_logs) }
  it { is_expected.to have_many(:notification_occurrences) }

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
