# frozen_string_literal: true

class CategoryImagesController < ApplicationController
  def create
    @category_image = CategoryImage.create(image_params)
  end

  def destroy
    @category_image = CategoryImage.find(params[:id])
    @category_image.destroy
  end

  private
    def image_params
      params.require(:category_image).permit(:name, :image, :remove_image, :category_uuid)
    end
end
