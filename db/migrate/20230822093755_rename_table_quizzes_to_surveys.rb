# frozen_string_literal: true

class RenameTableQuizzesToSurveys < ActiveRecord::Migration[6.1]
  def change
    rename_table :quizzes, :surveys
  end
end
