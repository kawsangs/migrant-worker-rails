# frozen_string_literal: true

class StoryFormsController < ApplicationController
  before_action :authorize_form, only: [:edit, :update, :destroy, :publish]

  def index
    respond_to do |format|
      format.html {
        @pagy, @forms = pagy(authorize Forms::StoryForm.all)
      }

      format.json {
        @forms = authorize Forms::StoryForm.all.includes(questions: [:options, :criterias])

        render json: @forms, include: ["questions", "questions.options"]
      }
    end
  end

  def new
    @form = authorize Forms::StoryForm.new
  end

  def create
    @form = authorize Forms::StoryForm.new(form_params)

    if @form.save
      redirect_to story_forms_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @form.update(form_params)
      redirect_to story_forms_url
    else
      render :edit
    end
  end

  def destroy
    @form.destroy

    redirect_to story_forms_url
  end

  def publish
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

    def authorize_form
      @form = authorize Forms::StoryForm.find(params[:id])
    end
end
