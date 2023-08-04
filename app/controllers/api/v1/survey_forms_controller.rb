# frozen_string_literal: true

module Api
  module V1
    class SurveyFormsController < ApplicationController
      def show
        form = Forms::SurveyForm.find(params[:id])

        render json: form, include: ["questions", "questions.options"]
      end
    end
  end
end
