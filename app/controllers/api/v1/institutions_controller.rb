# frozen_string_literal: true

module Api
  module V1
    class InstitutionsController < ApplicationController
      def index
        @institutions = Institution.all
        render json: @institutions, each_serializer: InstitutionSerializer
      end

      def show
      end
    end
  end
end
