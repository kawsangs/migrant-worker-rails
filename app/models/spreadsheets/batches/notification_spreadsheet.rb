# frozen_string_literal: true

module Spreadsheets
  module Batches
    class NotificationSpreadsheet
      attr_reader :notification

      def initialize(notification)
        @notification = notification
      end

      def process(row)
        notification.attributes = {
          title: row["title"],
          body: row["body"],
          schedule_mode: "onetime",
          start_time: schedule_at(row["schedule_date"])
        }

        notification
      end

      private
        def schedule_at(value, timezone = "+0700")
          date = format_date(value)
          return value if value.nil? || date.nil?

          Time.new(date.year, date.month, date.day, date.hour, date.min, date.sec, timezone)
        end

        def format_date(date)
          DateTime.parse date.to_s rescue nil
        end
    end
  end
end
