# frozen_string_literal: true

class AddCanceledAtToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :cancelled_at, :datetime
    add_column :notifications, :canceller_id, :integer
    rename_column :notification_occurrences, :cancel_at, :cancelled_at
  end
end
