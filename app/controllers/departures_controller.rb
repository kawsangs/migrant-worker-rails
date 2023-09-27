# frozen_string_literal: true

class DeparturesController < CategoriesController
  def index
    respond_to do |format|
      format.html {
        @pagy, @categories = pagy(authorize Categories::Departure.roots)
      }

      format.json {
        @categories = authorize Categories::Departure.all

        render json: @categories
      }
    end
  end

  private
    def param_type
      "Categories::Departure"
    end

    def do_redirect
      redirect_to departures_url
    end
end
