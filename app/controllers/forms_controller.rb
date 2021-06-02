# frozen_string_literal: true

class FormsController < ApplicationController
  def index
    @pagy, @forms = pagy(policy_scope(Form.all))
  end

  def new
    @form = Form.new
  end

  def create
    @form = Form.new(form_params)

    if @form.save
      redirect_to forms_url
    else
      render :new
    end
  end

  def edit
    @form = Form.find(params[:id])
  end

  def update
    @form = Form.find(params[:id])

    if @form.update(form_params)
      redirect_to forms_url
    else
      render :edit
    end
  end

  def destroy
    @form = Form.find(params[:id])
    @form.destroy

    redirect_to forms_url
  end

  def publish
    @form = Form.find(params[:id])
    @form.update(published: true)

    redirect_to forms_url
  end

  private
    def form_params
      params.require(:form).permit(:name, :form_type,
        questions_attributes: [
          :id, :name, :type, :required, :display_order, :code,
          :_destroy, :hint, :relevant, :audio, :remove_audio,
          :passing_score, :passing_message, :passing_audio,
          :failing_message, :failing_audio,
          options_attributes: %i[id name value score alert_audio remove_alert_audio alert_message other warning recursive _destroy],
          criterias_attributes: %i[id question_code operator response_value _destroy]
        ]
      )
    end
end
