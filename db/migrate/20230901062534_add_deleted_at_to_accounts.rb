# frozen_string_literal: true

class AddDeletedAtToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :deleted_at, :datetime
    add_column :accounts, :actived, :boolean, default: true
  end
end
