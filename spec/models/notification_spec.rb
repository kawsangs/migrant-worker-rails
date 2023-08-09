# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id              :bigint           not null, primary key
#  title           :string
#  body            :text
#  success_count   :integer
#  failure_count   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  published_at    :datetime
#  status          :integer          default("draft")
#  form_id         :integer
#  token_count     :integer          default(0)
#  schedule_mode   :integer          default("as_soon_as_release")
#  recurrence_rule :string
#  start_time      :datetime
#  end_time        :datetime
#
require "rails_helper"

RSpec.describe Notification, type: :model do
  describe "#after_commit, publish" do
    context "create" do
      it "adds job to sidekiq" do
        expect {
          create(:notification, published_at: Time.now)
        }.to change(NotificationJob.jobs, :count).by(1)
      end
    end

    context "update" do
      let(:notification) { create(:notification, published_at: nil) }

      it "adds job to sidekiq" do
        expect {
          notification.update(published_at: Time.now)
        }.to change(NotificationJob.jobs, :count).by(1)
      end
    end
  end

  describe "#after_commit, not publish" do
    context "create" do
      it "adds job to sidekiq" do
        expect {
          create(:notification, published_at: nil)
        }.to change(NotificationJob.jobs, :count).by(0)
      end
    end

    context "update" do
      let(:notification) { create(:notification, published_at: nil) }

      it "adds job to sidekiq" do
        expect {
          notification.update(title: "test")
        }.to change(NotificationJob.jobs, :count).by(0)
      end
    end
  end

  describe "validates #start_time" do
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

  describe "validates #recurrence_rule" do
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

  describe "validates #end_time" do
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
end
