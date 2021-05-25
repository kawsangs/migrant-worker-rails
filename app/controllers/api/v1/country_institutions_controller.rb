# frozen_string_literal: true

module Api
  module V1
    class CountryInstitutionsController < ApplicationController
      before_action :set_country

      def index
        @country_institutions = @country.country_institutions
        render  json: @country_institutions,
                include: ['institution', 'institution.contacts'],
                each_serializer: CountryInstitutionSerializer
      end

      private

      def set_country
        @country ||= Country.find(params[:country_id])
      end
    end
  end
end
