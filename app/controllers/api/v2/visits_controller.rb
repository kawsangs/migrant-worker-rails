# frozen_string_literal: true

module Api
  module V2
    class VisitsController < ApiController
      def create
        VisitJob.perform_async(visit_params.as_json)

        head :created
      end

      private
        def visit_params
          params.require(:visit).permit(
            :user_uuid, :visit_date, :pageable_id, :pageable_type, :device_id,
            page_attributes: [:code, :name, :parent_code]
          )
        end
    end
  end
end
