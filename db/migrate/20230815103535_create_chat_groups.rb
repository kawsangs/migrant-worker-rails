# frozen_string_literal: true

class CreateChatGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_groups, id: :uuid do |t|
      t.string   :title
      t.string   :chat_id
      t.string   :chat_type, default: "group"
      t.boolean  :active, default: true
      t.text     :reason
      t.string   :telegram_bot_user_id

      t.timestamps
    end
  end
end
