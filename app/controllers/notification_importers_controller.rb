# frozen_string_literal: true

class NotificationImportersController < ApplicationController
  include Batches::ItemableImportersConcern

  private
    def batch_type
      "NotificationBatch"
    end

    def redirect_success_url
      notifications_url
    end

    def redirect_error_url
      new_notification_importer_url
    end

    def itemable_attributes
      [:id, :title, :body, :schedule_mode, :start_time]
    end
end
