class CountriesController < ApplicationController
  def index
    @countries = Country.all
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(country_params)
    if @country.save
      redirect_to countries_path, status: :moved_permanently, notice: 'success'
    else
      render :new, status: :unprocessable_entity, alert: 'fail'
    end
  end

  def edit
    @country = Country.find(params[:id])
  end

  def update
    @country = Country.find(params[:id])
    if @country.update(country_params)
      redirect_to countries_path, status: :moved_permanently, notice: 'success'
    else
      render :new, status: :unprocessable_entity, alert: 'fail'
    end
  end

  private

  def country_params
    params.require(:country).permit(:name)
  end
end
