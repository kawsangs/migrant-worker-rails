# frozen_string_literal: true

class AddNotificationOccurrenceIdToSurveys < ActiveRecord::Migration[6.1]
  def change
    add_column :surveys, :notification_occurrence_id, :uuid
  end
end
