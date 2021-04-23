# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :set_type

      def index
        categories = category_class.roots

        render json: categories
      end

      def show
        category = category_class.find(params[:id])

        render json: category
      end

      private
        def set_type
          @type = Category.types.include?(params[:type]) ? params[:type] : "Category"
        end

        def category_class
          @type.constantize
        end
    end
  end
end
