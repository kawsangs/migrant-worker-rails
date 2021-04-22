# frozen_string_literal: true

class DeparturesController < ApplicationController
  def index
    @pagy, @categories = pagy(Categories::Departure.roots)
  end

  def new
    @category = authorize Categories::Departure.new(parent_id: params[:parent_id])
  end

  def edit
    @category = authorize Categories::Departure.find(params[:id])
  end

  def create
    @category = authorize Categories::Departure.new(category_params)

    if @category.save
      redirect_to departures_url
    else
      render :new
    end
  end

  def update
    @category = authorize Categories::Departure.find(params[:id])

    if @category.update(category_params)
      redirect_to departures_url
    else
      render :edit
    end
  end

  def destroy
    @category = authorize Categories::Departure.find(params[:id])
    @category.destroy

    redirect_to departures_url
  end

  private
    def category_params
      params.require(:categories_departure).permit(:name, :description, :parent_id,
        :image, :remove_image,
        :icon, :remove_icon,
        :audio, :remove_audio,
        :video, :remove_video,
        :pdf_file, :remove_pdf_file,
      )
    end
end
