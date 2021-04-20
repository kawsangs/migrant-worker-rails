# frozen_string_literal: true

class AddLanguageCodeToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :language_code, :string, default: "en"
  end
end
