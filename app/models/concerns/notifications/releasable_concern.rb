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
  end
end
