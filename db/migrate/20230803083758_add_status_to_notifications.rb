# frozen_string_literal: true

class AddStatusToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :published_at, :datetime
    add_column :notifications, :status, :integer, default: 0
  end
end
