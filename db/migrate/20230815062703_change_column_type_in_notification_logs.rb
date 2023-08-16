# frozen_string_literal: true

class ChangeColumnTypeInNotificationLogs < ActiveRecord::Migration[6.1]
  def change
    remove_column :notification_logs, :registered_token_id
    add_column :notification_logs, :registered_token_id, :integer
  end
end
