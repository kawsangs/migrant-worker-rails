# frozen_string_literal: true

module Notifications::SchedulableConcern
  extend ActiveSupport::Concern

  included do
    # Constant
    START_TIME = Date.today + 8.hours

    # Callback
    after_commit :create_notification_occurrence, on: [:update]

    # Instance method
    def increase_delivered_count
      self.class.increment_counter(:occurrences_delivered_count, id)
    end

    def occurrence_dates
      return [Time.now] if as_soon_as_release?
      return [start_time] if onetime?

      recurrence_dates
    end

    private
      def create_notification_occurrence
        return unless released?

        occurrence_dates.each do |occurrence_date|
          notification_occurrences.create(occurrence_date: occurrence_date)
        end
      end

      def recurrence_dates
        return @recurrence_dates if @recurrence_dates.present?

        schedule = IceCube::Schedule.new(START_TIME)
        schedule.add_recurrence_rule IceCube::Rule.from_hash(JSON.parse(recurrence_rule))
        @recurrence_dates = schedule.occurrences(end_time)
      end
  end
end
