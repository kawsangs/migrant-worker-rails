# frozen_string_literal: true

require_relative "account"
require_relative "migrant"
require_relative "need_for_help"

module Samples
  class Sample
    def self.load
      ::Samples::Account.load
      ::Samples::Migrant.load
      ::Samples::NeedForHelp.load
    end
  end
end
