# frozen_string_literal: true

class DeparturesController < CategoriesController
  def index
    @pagy, @categories = pagy(Categories::Departure.roots)
  end

  private
    def param_type
      "Categories::Departure"
    end

    def do_redirect
      redirect_to departures_url
    end
end
