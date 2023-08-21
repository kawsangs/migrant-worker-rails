# frozen_string_literal: true

class SurveyFormsController < ApplicationController
  def index
    @pagy, @forms = pagy(policy_scope(Forms::SurveyForm.includes(:questions, :notifications)))
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
    @form = authorize Forms::SurveyForm.find(params[:id])
  end

  def update
    @form = authorize Forms::SurveyForm.find(params[:id])

    if @form.update(form_params)
      redirect_to survey_forms_url
    else
      render :edit
    end
  end

  def destroy
    @form = authorize Forms::SurveyForm.find(params[:id])
    @form.destroy

    redirect_to survey_forms_url
  end

  private
    def form_params
      params.require(:forms_survey_form).permit(:name,
        sections_attributes: [
          :id, :name, :_destroy,
          questions_attributes: [
            :id, :name, :type, :required, :display_order, :code,
            :_destroy, :hint, :relevant, :audio, :remove_audio,
            options_attributes: [:id, :name, :value, :_destroy, chat_group_ids: []],
            criterias_attributes: %i[id question_code operator response_value _destroy]
          ]
        ]
      )
    end
end
