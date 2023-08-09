# frozen_string_literal: true

class AddTokenCountToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :token_count, :integer, default: 0
  end
end
