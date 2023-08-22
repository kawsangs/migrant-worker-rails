# frozen_string_literal: true

class CreateOptionsChatGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :options_chat_groups, id: :uuid do |t|
      t.integer :option_id
      t.uuid    :chat_group_id

      t.timestamps
    end
  end
end
