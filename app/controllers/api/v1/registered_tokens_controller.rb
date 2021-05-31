# frozen_string_literal: true

module Api
  module V1
    class RegisteredTokensController < ApplicationController
      def update
        @token = RegisteredToken.find_or_initialize_by(id: token_params['id'])

        if @token.update(token_params)
          render json: @token
        else
          render json: @token.errors, status: :unprocessable_entity
        end
      end

      private

      def token_params
        params.require(:registered_token).permit(:id, :token)
      end
    end
  end
end
