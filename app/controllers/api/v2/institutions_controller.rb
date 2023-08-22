# frozen_string_literal: true

module Api
  module V2
    class InstitutionsController < ApiController
      before_action :set_country

      def index
        @institutions = @country.institutions
        render json: @institutions, each_serializer: InstitutionSerializer
      end

      private
        def set_country
          @country ||= Country.find_by(code: params[:country_id])
        end
    end
  end
end
