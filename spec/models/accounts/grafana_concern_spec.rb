# frozen_string_literal: true

require "rails_helper"

RSpec.describe Accounts::GrafanaConcern, type: :model do
  describe "after_create, add_to_grafana_async" do
    context "dashboard_accessible is true" do
      let(:account) { build(:account, dashboard_accessible: true) }

      it "calls add_to_grafana_async" do
        expect(account).to receive(:add_to_grafana_async)
        account.save
      end
    end

    context "dashboard_accessible is false" do
      let(:account) { build(:account, dashboard_accessible: false) }

      it "doesn't call add_to_grafana_async" do
        expect(account).not_to receive(:add_to_grafana_async)
        account.save
      end
    end
  end

  describe "#after_update, add_to_grafana_async" do
    context "saved_change_to_dashboard_accessible and dashboard_accessible is true" do
      let(:account) { create(:account, dashboard_accessible: false) }

      it "calls add_to_grafana_async" do
        expect(account).to receive(:add_to_grafana_async)
        account.update(dashboard_accessible: true)
      end
    end

    context "saved change to role" do
      let(:account) { create(:account, dashboard_accessible: true, role: "system_admin") }

      it "doesn't call add_to_grafana_async" do
        expect(account).not_to receive(:add_to_grafana_async)
        account.update(role: "guest")
      end
    end
  end

  describe "#after_update, remove_from_grafana_async" do
    context "saved_change_to_dashboard_accessible and dashboard_accessible is false" do
      let(:account) { create(:account, dashboard_accessible: true, gf_user_id: 1) }

      it "calls remove_from_grafana_async" do
        expect(account).to receive(:remove_from_grafana_async)
        account.update(dashboard_accessible: false)
      end
    end
  end

  describe "#after_restore, add_to_grafana_async" do
    context "dashboard_accessible is true" do
      let(:account) { create(:account, dashboard_accessible: true, gf_user_id: 1) }

      before {
        allow(account).to receive(:unallow_access_dashboard?).and_return false
        account.destroy
      }

      it "calls add_to_grafana_async" do
        expect(account).to receive(:add_to_grafana_async)
        account.restore
      end
    end

    context "dashboard_accessible is false" do
      let(:account) { create(:account, dashboard_accessible: false) }

      before {
        allow(account).to receive(:unallow_access_dashboard?).and_return false
        account.destroy
      }

      it "calls add_to_grafana_async" do
        expect(account).not_to receive(:add_to_grafana_async)
        account.restore
      end
    end
  end

  describe "#after_destroy, remove_from_grafana_async" do
    context "dashboard_accessible is true" do
      let(:account) { create(:account, dashboard_accessible: true, gf_user_id: 1) }

      it "calls add_to_grafana_async" do
        expect(account).to receive(:remove_from_grafana_async)
        account.destroy
      end
    end

    context "dashboard_accessible is false" do
      let(:account) { create(:account, dashboard_accessible: false) }

      it "calls add_to_grafana_async" do
        expect(account).not_to receive(:remove_from_grafana_async)
        account.destroy
      end
    end
  end

  describe "#add_to_grafana_async" do
    context "unallow_access_dashboard? is false" do
      let(:account) { create(:account) }

      before {
        allow(account).to receive(:unallow_access_dashboard?).and_return false
      }

      it "adds a job to AccountJob" do
        expect {
          account.send(:add_to_grafana_async)
        }.to change(AccountJob.jobs, :count).by(1)
      end
    end

    context "unallow_access_dashboard? is true" do
      let(:account) { build(:account) }

      before {
        allow(account).to receive(:unallow_access_dashboard?).and_return true
      }

      it "doesn't add a job to AccountJob" do
        expect {
          account.send(:add_to_grafana_async)
        }.to change(AccountJob.jobs, :count).by(0)
      end
    end
  end

  describe "#remove_from_grafana_async" do
    context "unallow_access_dashboard? is false" do
      let(:account) { build(:account, gf_user_id: 1) }

      before {
        allow(account).to receive(:unallow_access_dashboard?).and_return false
      }

      it "adds a job to AccountJob" do
        expect {
          account.send(:remove_from_grafana_async)
        }.to change(AccountJob.jobs, :count).by(1)
      end
    end

    context "unallow_access_dashboard? is true" do
      let(:account) { build(:account) }

      before {
        allow(account).to receive(:unallow_access_dashboard?).and_return true
      }

      it "doesn't add a job to AccountJob" do
        expect {
          account.send(:remove_from_grafana_async)
        }.to change(AccountJob.jobs, :count).by(0)
      end
    end
  end
end
