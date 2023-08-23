# frozen_string_literal: true

class RenameTableAnswersToSurveyAnswers < ActiveRecord::Migration[6.1]
  def change
    rename_table :answers, :survey_answers
    rename_column :survey_answers, :quiz_uuid, :survey_uuid
  end
end
