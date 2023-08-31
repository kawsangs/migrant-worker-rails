# frozen_string_literal: true

class SurveyFormsController < ApplicationController
  before_action :set_form, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @forms = pagy(policy_scope(Forms::SurveyForm.includes(:questions, :notifications)))
  end

  def show
  end

  def new
    @form = authorize Forms::SurveyForm.new
  end

  def create
    @form = authorize Forms::SurveyForm.new(form_params)

    if @form.save
      redirect_to survey_forms_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @form.update(form_params)
      redirect_to survey_forms_url
    else
      render :edit
    end
  end

  def destroy
    @form.destroy

    redirect_to survey_forms_url
  end

  private
    def form_params
      params.require(:forms_survey_form).permit(
        :name, :tag_list, :description,
        sections_attributes: [
          :id, :name, :_destroy,
          questions_attributes: [
            :id, :name, :type, :required, :display_order, :code,
            :_destroy, :hint, :relevant, :audio, :remove_audio, :tag_list,
            options_attributes: [:id, :name, :value, :_destroy, chat_group_ids: []],
            criterias_attributes: %i[id question_code operator response_value _destroy]
          ]
        ]
      )
    end

    def set_form
      @form = authorize Forms::SurveyForm.find(params[:id])
    end
end
