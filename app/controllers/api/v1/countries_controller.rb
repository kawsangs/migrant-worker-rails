# frozen_string_literal: true

module Api
  module V1
    class CountriesController < ApplicationController
      def index
        @countries = Country.having_institutions

        render json: @countries, each_serializer: CountrySerializer
      end
    end
  end
end
