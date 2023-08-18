# frozen_string_literal: true

class StoryFormsController < ApplicationController
  def index
    @pagy, @forms = pagy(policy_scope(Forms::StoryForm.all))
  end

  def new
    @form = Forms::StoryForm.new
  end

  def create
    @form = Forms::StoryForm.new(form_params)

    if @form.save
      redirect_to story_forms_url
    else
      render :new
    end
  end

  def edit
    @form = Forms::StoryForm.find(params[:id])
  end

  def update
    @form = Forms::StoryForm.find(params[:id])

    if @form.update(form_params)
      redirect_to story_forms_url
    else
      render :edit
    end
  end

  def destroy
    @form = Forms::StoryForm.find(params[:id])
    @form.destroy

    redirect_to story_forms_url
  end

  def publish
    @form = Forms::StoryForm.find(params[:id])
    @form.publish

    redirect_to story_forms_url
  end

  private
    def form_params
      params.require(:forms_story_form).permit(:name,
        questions_attributes: [
          :id, :name, :type, :required, :display_order, :code,
          :_destroy, :hint, :relevant, :audio, :remove_audio,
          :passing_score, :passing_message, :passing_audio,
          :failing_message, :failing_audio,
          options_attributes: %i[id name value score alert_audio remove_alert_audio alert_message other warning recursive _destroy],
          criterias_attributes: %i[id question_code operator response_value _destroy]
        ]
      ).merge(form_type: Forms::StoryForm)
    end
end
