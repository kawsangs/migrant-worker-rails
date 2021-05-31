# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string  :code
      t.text    :name
      t.string  :type
      t.string  :hint
      t.integer :display_order
      t.string  :relevant
      t.boolean :required
      t.string  :audio
      t.integer :passing_score
      t.text    :passing_message
      t.string  :passing_audio
      t.text    :failing_message
      t.string  :failing_audio
      t.integer :form_id

      t.timestamps
    end
  end
end
