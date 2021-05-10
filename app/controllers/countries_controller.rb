class CountriesController < ApplicationController
  before_action :set_country, only: [:edit, :update, :destroy]

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
  end

  def update
    if @country.update(country_params)
      redirect_to countries_path, status: :moved_permanently, notice: 'success'
    else
      render :new, status: :unprocessable_entity, alert: 'fail'
    end
  end

  def destroy
    @country.destroy
    redirect_to countries_path, status: :moved_permanently, notice: 'success'
  end

  private

  def country_params
    params.require(:country).permit(:name)
  end

  def set_country
    @country = Country.find(params[:id])
  end
end
