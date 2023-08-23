# frozen_string_literal: true

module Api
  module V1
    class QuizzesController < ApplicationController
      def create
        @quiz = Survey.new(quiz_params)

        if @quiz.save
          render json: @quiz
        else
          render json: { errors: @quiz.error }
        end
      end

      private
        def quiz_params
          param = params.require(:quiz).permit(:id, :uuid, :user_uuid, :form_id, :quizzed_at,
            answers_attributes: [
              :uuid, :question_id, :question_code, :value, :score, :user_uuid
            ]
          )

          param[:survey_answers_attributes] = param[:answers_attributes]
          param.delete(:answers_attributes)
          param
        end
    end
  end
end
