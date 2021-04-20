# frozen_string_literal: true

module Samples
  class Account
    def self.load
      accounts = [
        { email: "admin@instedd.org", role: :system_admin },
        { email: "guest@instedd.org", role: :guest }
      ]

      accounts.each do |account|
        u = ::Account.new(account.merge({ password: "123456" }))
        u.confirm
      end
    end
  end
end
