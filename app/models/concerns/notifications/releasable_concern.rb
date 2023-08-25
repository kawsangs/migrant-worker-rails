# frozen_string_literal: true

module Notifications::ReleasableConcern
  extend ActiveSupport::Concern

  included do
    # Validation
    validates :releasor_id, presence: true, if: -> { released? }
    validates :canceller_id, presence: true, if: -> { cancelled? }
    validate :cancellable, if: -> { cancelled? }

    # Callback
    after_update :cancel_pending_notification_occurrence, if: -> { cancelled? }
    after_update :published_survey_form, if: -> { released? && form_id.present? }

    # Instance method
    def cancelled_by(canceller_id)
      self.update(cancelled_at: Time.zone.now, status: "cancelled", canceller_id: canceller_id)
    end

    def released_by(releasor_id)
      self.update(released_at: Time.zone.now, status: "released", releasor_id: releasor_id)
    end

    private
      def cancel_pending_notification_occurrence
        notification_occurrences.pending.map { |occurrence| occurrence.cancel }
      end

      def cancellable
        if completed?
          errors.add :base, I18n.t("notification.cannot_cancell")
          throw(:abort)
        end
      end

      def published_survey_form
        survey_form.publish unless survey_form.published?
      end
  end
end