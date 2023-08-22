# frozen_string_literal: true

module Api
  module V2
    class CountriesController < ApiController
      def index
        @countries = Country.having_institutions

        render json: @countries, each_serializer: CountrySerializer
      end
    end
  end
end
