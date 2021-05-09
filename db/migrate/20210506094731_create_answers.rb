# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.string  :uuid
      t.integer :question_id
      t.string  :question_code
      t.string  :value
      t.integer :score
      t.string  :user_uuid
      t.string  :quiz_uuid

      t.timestamps
    end
  end
end
