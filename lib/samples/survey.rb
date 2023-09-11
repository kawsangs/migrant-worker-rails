# frozen_string_literal: true

require_relative "base"

module Samples
  class Survey < Samples::Base
    def simulate
      ::Survey.create(
        uuid: SecureRandom.uuid,
        user_uuid: user.uuid,
        form_id: survey_form.id,
        quizzed_at: rand(1..100).days.ago,
        survey_answers_attributes: survey_answers_attributes
      )
    end

    private
      def user
        @user ||= ::User.all.sample
      end

      def survey_form
        @survey_form ||= Forms::SurveyForm.all.sample
      end

      def survey_answers_attributes
        survey_form.questions.map do |question|
          {
            uuid: SecureRandom.uuid,
            question_id: question.id,
            question_code: question.code,
            value: question.options.sample.value || FFaker::Name.name,
            user_uuid: user.uuid
          }
        end
      end
  end
end
