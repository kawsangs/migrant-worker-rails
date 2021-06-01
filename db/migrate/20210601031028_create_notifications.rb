# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string  :title
      t.text    :body
      t.integer :success_count
      t.integer :failure_count

      t.timestamps
    end
  end
end
