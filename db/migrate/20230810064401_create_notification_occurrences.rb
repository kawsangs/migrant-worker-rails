# frozen_string_literal: true

class CreateNotificationOccurrences < ActiveRecord::Migration[6.1]
  def change
    create_table :notification_occurrences, id: :uuid do |t|
      t.integer  :notification_id
      t.datetime :occurrence_date
      t.integer  :token_count, default: 0
      t.integer  :success_count, default: 0
      t.integer  :failure_count, default: 0
      t.integer  :status, default: 1
      t.string   :job_id
      t.datetime :cancel_at

      t.timestamps
    end
  end
end
