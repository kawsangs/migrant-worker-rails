# frozen_string_literal: true

class CreateQuizzes < ActiveRecord::Migration[6.0]
  def change
    create_table :quizzes do |t|
      t.string   :uuid
      t.string   :user_uuid
      t.integer  :form_id
      t.datetime :quizzed_at

      t.timestamps
    end
  end
end
