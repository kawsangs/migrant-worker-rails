# frozen_string_literal: true

require_relative 'account'
require_relative 'migrant'

module Samples
  class Sample
    def self.load
      ::Samples::Account.load
      ::Samples::Migrant.load
    end
  end
end
