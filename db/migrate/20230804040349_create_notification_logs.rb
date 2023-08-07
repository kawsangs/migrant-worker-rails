# frozen_string_literal: true

class CreateNotificationLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :notification_logs, id: :uuid do |t|
      t.integer :notification_id
      t.uuid    :registered_token_id
      t.text    :failed_reason

      t.timestamps
    end
  end
end
