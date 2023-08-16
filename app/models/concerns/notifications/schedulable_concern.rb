# frozen_string_literal: true

module Notifications::SchedulableConcern
  extend ActiveSupport::Concern

  included do
    # Enum
    enum schedule_mode: {
      as_soon_as_release: 0,
      onetime: 1,
      recurrence: 2
    }

    # Validation
    validates :start_time, presence: true, if: -> { onetime? }
    validates :recurrence_rule, presence: true, if: -> { recurrence? }
    validates :end_time, presence: true, if: -> { recurrence? }

    validate  :start_time_cannot_be_in_the_past, if: -> { onetime? }
    validate  :end_time_must_be_at_lease_tomorrow, if: -> { recurrence? }

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

    def display_schedule
      return I18n.t("notification.as_soon_as_release") if as_soon_as_release?
      return I18n.l(start_time) if onetime?

      RecurringSelect.dirty_hash_to_rule(recurrence_rule)
    end

    # Class method
    def self.schedule_mode_list
      [
        [I18n.t("notification.as_soon_as_release"), "as_soon_as_release"],
        [I18n.t("notification.onetime"), "onetime"],
        [I18n.t("notification.recurrence"), "recurrence"]
      ]
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

      def start_time_cannot_be_in_the_past
        if start_time.present? && start_time < Time.zone.now + 5.minutes
          errors.add(:start_time, "must be bigger than current time at least 5 minutes")
        end
      end

      def end_time_must_be_at_lease_tomorrow
        if end_time.present? && end_time < Date.tomorrow.in_time_zone("Bangkok")
          errors.add(:end_time, "must be bigger than today")
        end
      end
  end
end
