# frozen_string_literal: true

class LocalesController < ApplicationController
  def update
    if current_account.update(locale_params)
      head :ok
    else
      render json: current_account.errors.messages
    end
  end

  private
    def locale_params
      params.require(:account).permit(:language_code)
    end
end
