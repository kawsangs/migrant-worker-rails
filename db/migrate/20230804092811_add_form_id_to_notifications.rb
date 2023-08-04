# frozen_string_literal: true

class AddFormIdToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :form_id, :integer
  end
end
