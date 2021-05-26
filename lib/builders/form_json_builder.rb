# frozen_string_literal: true

class FormJsonBuilder
  attr_accessor :form

  def initialize(form)
    @form = form
  end

  def build
    data = JSON.parse(ActiveModelSerializers::SerializableResource.new(form, {include: ["questions", "questions.options"]}).to_json)
    assign_form_assets(data)

    data["questions"].each do |question|
      assign_question_assets(question)
    end

    data
  end

  private
    def assign_form_assets(data)
      data["image"] = "require('../../assets/images/form/#{data["image_url"].split('/').last}')" if data["image_url"].present?
      data["audio"] = data["audio_url"].split('/').last if data["audio_url"].present?
      data["offline"] = true
    end

    def assign_question_assets(data)
      data["audio"] = data["audio_url"].split('/').last if data["audio_url"].present?
      data["passing_audio"] = data["passing_audio_url"].split('/').last if data["passing_audio_url"].present?
      data["failing_audio"] = data["failing_audio_url"].split('/').last if data["failing_audio_url"].present?
      data["offline"] = true

      data["options"].each do |option|
        assign_option_assets(option)
      end
    end

    def assign_option_assets(data)
      data["image"] = "require('../../assets/images/form/#{data["image_url"].split('/').last}')" if data["image_url"].present?
      data["alert_audio"] = data["alert_audio_url"].split('/').last if data["alert_audio_url"].present?
      data["offline"] = true
    end
end
