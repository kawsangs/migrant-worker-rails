# frozen_string_literal: true

class CategoriesController < ApplicationController
  def new
    @category = authorize Category.new(parent_id: params[:parent_id])
  end

  def edit
    @category = authorize Category.find(params[:id])
  end

  def create
    @category = authorize Category.new(category_params)

    if @category.save
      do_redirect
    else
      render :new
    end
  end

  def update
    @category = authorize Category.find(params[:id])

    if @category.update(category_params)
      do_redirect
    else
      render :edit
    end
  end

  def destroy
    @category = authorize Category.find(params[:id])
    @category.destroy

    do_redirect
  end

  private
    def do_redirect
      redirect_to action: "index"
    end

    def category_class
      @type.constantize
    end

    def category_params
      params.require(:category).permit(:name, :description, :parent_id,
        :image, :remove_image,
        :audio, :remove_audio
      ).merge(type: param_type)
    end

    def param_type
      ""
    end
end
