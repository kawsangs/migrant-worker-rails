# frozen_string_literal: true

module Accounts::GrafanaConcern
  extend ActiveSupport::Concern

  included do
    after_create :add_to_grafana_async, if: -> { confirmed? }
    after_update :add_to_grafana_async, if: -> { (was_confirmed? || was_activated?) }
    after_update :remove_from_grafana_async, if: -> { was_deactivated? }

    # For soft delete
    after_restore :add_to_grafana_async, if: -> { confirmed? }
    after_destroy :remove_from_grafana_async

    def add_to_dashboard
      Grafana.new.add_user(self)
    end

    def remove_from_dashboard
      Grafana.new.remove_user(self)
    end

    def add_to_grafana_async
      return if unallow_access_dashboard?

      AccountJob.perform_async("add_to_dashboard", id) if gf_user_id.nil?
    end

    def remove_from_grafana_async
      return if unallow_access_dashboard?

      AccountJob.perform_async("remove_from_dashboard", id) if gf_user_id.present?
    end

    private
      def was_activated?
        saved_change_to_actived? && actived?
      end

      def was_deactivated?
        saved_change_to_actived? && !actived?
      end

      def was_confirmed?
        saved_change_to_confirmed_at? && confirmed?
      end

      def unallow_access_dashboard?
        skip_callback || ENV["GF_DASHBOARD_URL"].blank?
      end
  end
end
