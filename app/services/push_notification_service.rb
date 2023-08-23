# frozen_string_literal: true

# Message template follow: https://github.com/decision-labs/fcm

require "googleauth"

class PushNotificationService
  attr_reader :notification_occurrence

  def initialize(notification_occurrence)
    @notification_occurrence = notification_occurrence
  end

  def notify(token)
    message = { 'token': token }.merge(notification_occurrence.build_content)

    fcm.send_v1(message)
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
