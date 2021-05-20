class InstitutionsController < ApplicationController
  def index
    @pagy, @institutions = pagy(Institution.includes(:contacts, :country_institutions))
  end

  def new
    @institution = Institution.new
  end

  def create
    @institution = Institution.new(institution_params)
    if @institution.save
      redirect_to institutions_path, status: :moved_permanently, notice: I18n.t(:success, scope: :create)
    else
      render :new, status: :unprocessable_entity, alert: I18n.t(:fail, scope: :create)
    end
  end

  def edit
    @institution = Institution.find(params[:id])
  end

  def update
    @institution = Institution.find(params[:id])

    if @institution.update(institution_params)
      redirect_to institutions_path, status: :moved_permanently, notice: I18n.t(:success, scope: :update)
    else
      render :edit, status: :unprocessable_entity, alert: I18n.t(:fail, scope: :update)
    end
  end

  def destroy
    @institution = Institution.find(params[:id])
    @institution.destroy
    redirect_to institutions_path, status: :moved_permanently, notice: I18n.t(:success, scope: :destroy)
  end

  private

  def institution_params
    params.require('institution').permit(
      :name, 
      :kind, 
      :address,
      country_institutions_attributes: [:id, :country_name, :_destroy],
      contacts_attributes: [:id, :type, :value, :_destroy]
    )
  end
end
