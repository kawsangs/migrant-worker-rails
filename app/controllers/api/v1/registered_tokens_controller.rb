# frozen_string_literal: true

module Api
  module V1
    class RegisteredTokensController < ApplicationController
      def update
        @token = RegisteredToken.from_param(token_params)

        if @token.update(token_params)
          render json: @token
        else
          render json: @token.errors, status: :unprocessable_entity
        end
      end

      private
        def token_params
          params.require(:registered_token).permit(
            :id, :token, :device_id, :device_type, :app_version
          )
        end
    end
  end
end
