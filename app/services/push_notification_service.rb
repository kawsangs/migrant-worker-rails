# frozen_string_literal: true

# Message template follow: https://github.com/decision-labs/fcm

require "googleauth"

class PushNotificationService
  attr_reader :success_count, :failure_count, :notification

  def initialize(notification)
    @notification = notification
    @success_count = 0
    @failure_count = 0
  end

  def notify_all(registered_tokens)
    registered_tokens.each do |registered_token|
      notify(registered_token)
    end

    { success_count: success_count, failure_count: failure_count }
  end

  def notify(registered_token)
    message = { 'token': registered_token.token }.merge(notification.build_content)
    res = fcm.send_v1(message)

    if res[:status_code] == 200
      @success_count += 1
    else
      @failure_count += 1

      notification.notification_logs.create(registered_token_id: registered_token.id, failed_reason: res[:body])
    end
  end

  private
    def fcm
      @fcm ||= FCM.new(
        access_token,
        credential_path,
        ENV["FIREBASE_PROJECT_ID"]
      )
    end

    def access_token
      @access_token ||= get_token
    end

    def credential_path
      @credential_path ||= Rails.root.join(ENV["GOOGLE_APPLICATION_CREDENTIALS_PATH"])
    end

    def get_token
      scope = "https://www.googleapis.com/auth/firebase.messaging"

      authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
        json_key_io: File.open(credential_path),
        scope: scope
      )

      authorizer.fetch_access_token!["access_token"]
    end
end
