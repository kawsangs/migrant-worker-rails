# frozen_string_literal: true

module Notifications::NotifiableConcern
  extend ActiveSupport::Concern

  included do
    # Callback
    after_commit :notify_all_async, on: [:update, :create]

    def finished?
      success_count.to_i + failure_count.to_i >= token_count
    end

    def notify_all
      update(token_count: registered_tokens.length)

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

        notification_logs.create(registered_token_id: registered_token.id, failed_reason: response[:body])
      end

      mark_as_delivered if self.reload.finished?
    end

    private
      def notify_all_async
        NotificationJob.perform_async(id) if published?
      end

      def registered_tokens
        @registered_tokens = RegisteredToken.all
      end

      def mark_as_delivered
        update(status: "delivered")
      end
  end
end
