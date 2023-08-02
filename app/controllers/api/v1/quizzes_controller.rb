# frozen_string_literal: true

module Api
  module V1
    class QuizzesController < ApplicationController
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
          params.require(:quiz).permit(:id, :uuid, :user_uuid, :form_id, :quizzed_at,
            answers_attributes: [
              :uuid, :question_id, :question_code, :value, :score, :user_uuid, :quiz_uuid
            ]
          )
        end
    end
  end
end
