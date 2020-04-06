class AccountWorker
  include Sidekiq::Worker

  def perform(id, action)
    account = Account.find_by(id: id)

    return if account.nil?

    account.send(action.to_sym)
  end
end
