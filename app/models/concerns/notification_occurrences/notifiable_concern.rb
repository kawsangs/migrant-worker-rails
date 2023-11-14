# frozen_string_literal: true

module NotificationOccurrences::NotifiableConcern
  extend ActiveSupport::Concern

  included do
    # Callback
    after_commit :notify_occurence_async, on: [:create]

    def notify_all_token_async
      self.update(token_count: registered_tokens.length, status: "in_progress")

      registered_tokens.find_each do |token|
        PushNotificationJob.perform_async(id, token.id)
      end
    end

    def notify(registered_token)
      PushNotificationService.new(self).notify(registered_token.token)
    end

    def update_progress_status(response, registered_token)
      if response[:status_code] == 200
        self.class.increment_counter(:success_count, id)
      else
        self.class.increment_counter(:failure_count, id)

        NotificationLog.create(notification_id: notification_id, registered_token_id: registered_token.id, failed_reason: response[:body])
      end

      mark_as_delivered if self.reload.finished?
    end

    def finished?
      success_count.to_i + failure_count.to_i == token_count
    end

    private
      def notify_occurence_async
        job_id = NotificationOccurrenceJob.perform_at(occurrence_date, id)

        self.update(job_id: job_id)
      end

      def registered_tokens
        @registered_tokens ||= RegisteredToken.all
      end
  end
end
