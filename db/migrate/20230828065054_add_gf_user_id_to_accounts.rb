# frozen_string_literal: true

class AddGfUserIdToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :gf_user_id, :integer
  end
end
