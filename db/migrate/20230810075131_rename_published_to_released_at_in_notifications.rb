# frozen_string_literal: true

class RenamePublishedToReleasedAtInNotifications < ActiveRecord::Migration[6.1]
  def change
    rename_column :notifications, :published_at, :released_at
  end
end
