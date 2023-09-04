# frozen_string_literal: true

module Accounts::OauthProvider
  extend ActiveSupport::Concern

  included do
    # Door keeper association
    has_many :access_grants,
              class_name: "Doorkeeper::AccessGrant",
              foreign_key: :resource_owner_id,
              dependent: :delete_all # or :destroy if you need callbacks

    has_many :access_tokens,
              class_name: "Doorkeeper::AccessToken",
              foreign_key: :resource_owner_id,
              dependent: :delete_all # or :destroy if you need callbacks
  end
end
