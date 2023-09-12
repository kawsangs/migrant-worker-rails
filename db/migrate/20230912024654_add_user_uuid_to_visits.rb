# frozen_string_literal: true

class AddUserUuidToVisits < ActiveRecord::Migration[6.1]
  def change
    add_column :visits, :user_uuid, :string
    remove_column :visits, :user_id
  end
end
