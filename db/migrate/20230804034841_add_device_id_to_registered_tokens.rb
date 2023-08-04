# frozen_string_literal: true

class AddDeviceIdToRegisteredTokens < ActiveRecord::Migration[6.1]
  def change
    add_column :registered_tokens, :device_id, :string
    add_column :registered_tokens, :device_type, :string
    add_column :registered_tokens, :app_version, :string
  end
end
