# frozen_string_literal: true

module Api
  module V2
    class SurveysController < ApiController
      def create
        @survey = Survey.new(survey_params)

        if @survey.save
          render json: @survey
        else
          render json: { errors: @survey.error }
        end
      end

      private
        def survey_params
          params.require(:survey).permit(:id, :uuid, :user_uuid, :form_id, :quizzed_at,
            :notification_id, :notification_occurrence_id,
            survey_answers_attributes: [
              :uuid, :question_id, :question_code, :value, :score, :user_uuid
            ]
          )
        end
    end
  end
end
