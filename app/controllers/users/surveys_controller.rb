# frozen_string_literal: true

module Users
  class SurveysController < ApplicationController
    before_action :assign_user

    def index
      @pagy, @surveys = pagy(@user.surveys.includes(:survey_answers, :user, :form))
    end

    def show
      @survey = Survey.find(params[:id])

      respond_to do |format|
        format.js
      end
    end

    private
      def assign_user
        @user = User.find(params[:user_id])
      end
  end
end
