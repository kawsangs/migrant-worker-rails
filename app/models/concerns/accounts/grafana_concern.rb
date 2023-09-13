# frozen_string_literal: true

module Accounts::GrafanaConcern
  extend ActiveSupport::Concern

  included do
    after_create :add_to_grafana_async, if: -> { dashboard_accessible? }
    after_update :add_to_grafana_async, if: -> { saved_change_to_dashboard_accessible && dashboard_accessible? }
    after_update :remove_from_grafana_async, if: -> { saved_change_to_dashboard_accessible && !dashboard_accessible? }

    # For soft delete
    after_restore :add_to_grafana_async, if: -> { dashboard_accessible? }
    after_destroy :remove_from_grafana_async, if: -> { dashboard_accessible? }

    def enable_dashboard
      self.update(dashboard_accessible: true)
    end

    def disable_dashboard
      self.update(dashboard_accessible: false)
    end

    def add_to_dashboard
      GrafanaService.new.add_user(self)
    end

    def remove_from_dashboard
      GrafanaService.new.remove_user(self)
    end

    private
      def add_to_grafana_async
        return if unallow_access_dashboard?

        AccountJob.perform_async("add_to_dashboard", id) if gf_user_id.nil?
      end

      def remove_from_grafana_async
        return if unallow_access_dashboard?

        AccountJob.perform_async("remove_from_dashboard", id) if gf_user_id.present?
      end

      def unallow_access_dashboard?
        skip_callback || ENV["GF_DASHBOARD_URL"].blank?
      end
  end
end
