# frozen_string_literal: true

module Api
  module V2
    class FormsController < ApiController
      def index
        forms = Forms::StoryForm.published

        render json: forms, include: ["questions", "questions.options"]
      end

      def show
        form = Forms::StoryForm.find(params[:id])

        render json: form, include: ["questions", "questions.options"]
      end
    end
  end
end
