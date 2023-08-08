# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id            :bigint           not null, primary key
#  title         :string
#  body          :text
#  success_count :integer
#  failure_count :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  published_at  :datetime
#  status        :integer          default("draft")
#  form_id       :integer
#  token_count   :integer          default(0)
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
end
