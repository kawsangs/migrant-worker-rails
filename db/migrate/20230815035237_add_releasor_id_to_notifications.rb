# frozen_string_literal: true

class AddReleasorIdToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :releasor_id, :integer
  end
end
