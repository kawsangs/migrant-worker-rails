# frozen_string_literal: true

class AddTrackingToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :tracking, :boolean, default: false
  end
end
