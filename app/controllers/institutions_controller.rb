# frozen_string_literal: true

class InstitutionsController < ApplicationController
  before_action :set_institution, only: [:edit, :update, :destroy, :delete_logo, :delete_audio]

  def index
    @pagy, @institutions = pagy(Institution.filter(filter_params).includes(:contacts, :country_institutions).order("updated_at DESC"))
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
  end

  def update
    if @institution.update(institution_params)
      redirect_to institutions_path, status: :moved_permanently, notice: I18n.t(:success, scope: :update)
    else
      render :edit, status: :unprocessable_entity, alert: I18n.t(:fail, scope: :update)
    end
  end

  def destroy
    @institution.destroy
    redirect_to institutions_path, status: :moved_permanently, notice: I18n.t(:success, scope: :destroy)
  end

  def delete_logo
    @institution.remove_logo!
    @institution.save!
    redirect_to institutions_path, status: :moved_permanently, notice: I18n.t(:success, scope: :destroy)
  end

  def delete_audio
    @institution.remove_audio!
    @institution.save!
    redirect_to institutions_path, status: :moved_permanently, notice: I18n.t(:success, scope: :destroy)
  end

  private
    def set_institution
      @institution ||= Institution.find(params[:id])
    end

    def institution_params
      params.require("institution").permit(
        :name,
        :name_km,
        :address,
        :logo,
        :audio,
        country_institutions_attributes: [:id, :country_name, :country_code, :_destroy],
        contacts_attributes: [:id, :type, :value, :_destroy]
      )
    end

    def filter_params
      params.permit(:name, :start_date, :end_date)
    end
end
