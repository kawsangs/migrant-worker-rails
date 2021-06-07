# frozen_string_literal: true

class AddPublishedAtToForms < ActiveRecord::Migration[6.0]
  def change
    add_column :forms, :published_at, :datetime
    remove_column :forms, :published
  end
end
