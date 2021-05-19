# frozen_string_literal: true

module Api
  module V1
    class CountriesController < ApplicationController
      def index
        @countries = Country.query(params[:query]).limit(10)
        render json: @countries, each_serializer: CountrySerializer
      end

      def show
      end
    end
  end
end
