module Api
  module V1
    class MigrantsController < ApplicationController
      def create
        migrant = Migrant.new(migrant_params)
        migrant.voice = params[:voice]

        if migrant.save
          render json: migrant, status: :created
        else
          render json: migrant.errors, status: :unprocessable_entity
        end
      end

      private
        def migrant_params
          params.require(:migrant).permit(:full_name, :sex, :age, :voice)
        end
    end
  end
end
