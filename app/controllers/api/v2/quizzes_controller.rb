# frozen_string_literal: true

module Api
  module V2
    class QuizzesController < ApiController
      def create
        @quiz = Quiz.new(quiz_params)

        if @quiz.save
          render json: @quiz
        else
          render json: { errors: @quiz.error }
        end
      end

      private
        def quiz_params
          params.require(:quiz).permit(:id, :uuid, :user_uuid, :form_id, :quizzed_at, :notification_id,
            answers_attributes: [
              :uuid, :question_id, :question_code, :value, :score, :user_uuid, :quiz_uuid
            ]
          )
        end
    end
  end
end
