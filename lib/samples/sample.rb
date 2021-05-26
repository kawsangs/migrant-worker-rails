# frozen_string_literal: true

Dir["/app/lib/builders/*.rb"].each { |file| require file }
Dir["/app/lib/exporters/*.rb"].each { |file| require file }

require_relative "account"
require_relative "migrant"
require_relative "need_for_help"
require_relative "category"
require_relative "form"

module Samples
  class Sample
    def self.load
      ::Samples::Account.load
      ::Samples::Migrant.load
      ::Samples::NeedForHelp.load
      ::Samples::Category.load
      ::Samples::Form.load
    end
  end
end
