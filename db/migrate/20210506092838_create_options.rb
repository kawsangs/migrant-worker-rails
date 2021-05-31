# frozen_string_literal: true

class CreateOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :options do |t|
      t.integer  :question_id
      t.string   :name
      t.string   :value
      t.integer  :score
      t.string   :alert_audio
      t.text     :alert_message
      t.boolean  :warning
      t.boolean  :recursive

      t.timestamps
    end
  end
end
