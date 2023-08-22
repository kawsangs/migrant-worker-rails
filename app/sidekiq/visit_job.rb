# frozen_string_literal: true

class VisitJob
  include Sidekiq::Job

  def perform(params = {})
    visit = Visit.new(visit_params(params))
    visit.save if visit.last_visit.nil?
  end

  private
    def visit_params(params)
      ActionController::Parameters.new(params)
        .permit(
          :user_id, :visit_date, :pageable_id, :pageable_type, :device_id,
          page_attributes: [:code, :name, :parent_code]
        )
    end
end
