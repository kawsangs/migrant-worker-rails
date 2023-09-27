# frozen_string_literal: true

class SafetiesController < CategoriesController
  def index
    respond_to do |format|
      format.html {
        @pagy, @categories = pagy(authorize Categories::Safety.roots)
      }

      format.json {
        @categories = authorize Categories::Safety.all

        render json: @categories
      }
    end
  end

  private
    def param_type
      "Categories::Safety"
    end

    def do_redirect
      redirect_to safeties_url
    end
end
