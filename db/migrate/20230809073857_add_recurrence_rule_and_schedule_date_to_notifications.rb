# frozen_string_literal: true

class AddRecurrenceRuleAndScheduleDateToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :schedule_mode, :integer, default: 0
    add_column :notifications, :recurrence_rule, :string
    add_column :notifications, :start_time, :datetime
    add_column :notifications, :end_time, :datetime
  end
end
