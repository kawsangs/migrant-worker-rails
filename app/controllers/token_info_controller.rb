# frozen_string_literal: true

class TokenInfoController < Doorkeeper::ApplicationMetalController
  def show
    if doorkeeper_token&.accessible?
      render json: doorkeeper_token_to_json, status: :ok
    else
      error = OAuth::InvalidTokenResponse.new
      response.headers.merge!(error.headers)
      render json: error_to_json(error), status: error.status
    end
  end

  protected
    def doorkeeper_token_to_json
      user = Account.find(doorkeeper_token.resource_owner_id)
      obj = doorkeeper_token.as_json
      obj[:email] = GrafanaPolicy.new(user, :grafana).show? ? user.email : "unauthorized_user@myjourneys.info"
      obj
    end

    def error_to_json(error)
      error.body
    end
end
