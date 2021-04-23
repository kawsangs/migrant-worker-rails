# frozen_string_literal: true

class SafetiesController < CategoriesController
  def index
    @pagy, @categories = pagy(Categories::Safety.roots)
  end

  private
    def param_type
      "Categories::Safety"
    end

    def do_redirect
      redirect_to safeties_url
    end
end
