# frozen_string_literal: true

class CountryJsonBuilder
  attr_accessor :country

  def initialize(country)
    @country = country
  end

  def build
    JSON.parse(ActiveModelSerializers::SerializableResource.new(country).to_json)
  end
end
