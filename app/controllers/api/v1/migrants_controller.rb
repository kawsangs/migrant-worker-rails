module Api
  module V1
    class MigrantsController < ::Api::V1::ApplicationController
      def create
        params[:migrant] = JSON.parse(params[:migrant])
        migrant = Migrant.find_or_initialize_by(uuid: migrant_params[:uuid])

        if migrant.update_attributes(migrant_params)
          render json: migrant, status: :created
        else
          render json: migrant.errors, status: :unprocessable_entity
        end
      end

      private
        def migrant_params
          param = params.require(:migrant).permit(:uuid, :full_name, :sex, :age, :phone_number)
          param = param.merge(voice: params[:voice]) if params[:voice].present?
          param
        end
    end
  end
end
