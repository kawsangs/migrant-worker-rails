# frozen_string_literal: true

class AccountJob
  include Sidekiq::Job

  def perform(operation, account_id)
    return if ENV["GF_DASHBOARD_URL"].blank?

    account = Account.with_deleted.find(account_id)
    account.send(operation)
  end
end
