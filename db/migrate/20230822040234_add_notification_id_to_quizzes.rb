# frozen_string_literal: true

class AddNotificationIdToQuizzes < ActiveRecord::Migration[6.1]
  def change
    add_column :quizzes, :notification_id, :integer
  end
end
