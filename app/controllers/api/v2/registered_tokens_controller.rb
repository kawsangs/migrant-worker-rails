# frozen_string_literal: true

module Api
  module V2
    class RegisteredTokensController < ApiController
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
            :id, :token, :device_id, :device_type, :device_os, :app_version
          )
        end
    end
  end
end
