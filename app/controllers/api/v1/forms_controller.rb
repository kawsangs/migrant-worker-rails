# frozen_string_literal: true

module Api
  module V1
    class FormsController < ApplicationController
      def index
        forms = Form.all

        render json: forms
      end

      def show
        form = Form.find(params[:id])

        render json: form, include: ["questions", "questions.options"]
      end
    end
  end
end
