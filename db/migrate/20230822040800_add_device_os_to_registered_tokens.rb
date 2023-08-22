# frozen_string_literal: true

class AddDeviceOsToRegisteredTokens < ActiveRecord::Migration[6.1]
  def change
    add_column :registered_tokens, :device_os, :integer
  end
end
