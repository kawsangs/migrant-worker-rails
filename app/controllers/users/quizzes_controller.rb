module Users
  class QuizzesController < ApplicationController
    before_action :assign_user

    def index
      @pagy, @quizzes = pagy(@user.quizzes.includes(:answers, :user, :form))
    end

    def show
      @quiz = Quiz.find(params[:id])

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
