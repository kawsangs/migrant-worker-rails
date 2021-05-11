class InstitutionsController < ApplicationController
  def index
    @institutions = Institution.all
  end

  def new
    @institution = Institution.new
  end

  def create
    @institution = Institution.new(institution_params)
    if @institution.save
      redirect_to institutions_path, status: :moved_permanently, notice: 'success'
    else
      render :new, status: :unprocessable_entity, alert: 'fail'
    end
  end

  def edit
    @institution = Institution.find(params[:id])
  end

  def update
    @institution = Institution.find(params[:id])

    if @institution.update(institution_params)
      redirect_to institutions_path, status: :moved_permanently, notice: 'success'
    else
      render :edit, status: :unprocessable_entity, alert: 'fail'
    end
  end

  def destroy
    @institution = Institution.find(params[:id])
    @institution.destroy
    redirect_to institutions_path, status: :moved_permanently, notice: 'success'
  end

  private

  def institution_params
    params.require('institution').permit(
      :name, 
      :kind, 
      country_institutions_attributes: [:id, :country_code, :_destroy]
    )
  end
end
