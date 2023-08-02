# frozen_string_literal: true

CarrierWave.configure do |config|
  if Rails.env.production?
    config.asset_host ActionController::Base.asset_host
  end
end
