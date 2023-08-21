# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::QuizzesController", type: :request do
  describe "PUT #create" do
    let(:api_key) { create(:api_key) }
    let(:headers) { { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" } }
    let(:user) { create(:user) }
    let(:form) { create(:form, :with_question_and_options) }
    let(:question) { form.questions.first }

    context "answer option has no chat groups" do
      let(:params) {
        {
          uuid: "abc",
          user_uuid: user.uuid,
          form_id: form.id,
          quizzed_at: Date.today,
          answers_attributes: [
            {
              uuid: "123",
              question_id: question.id,
              question_code: question.code,
              value: question.options.first.value,
              user_uuid: user.uuid,
              quiz_uuid: "abc"
            }
          ]
        }
      }

      it "creates a quiz" do
        expect {
          post "/api/v1/quizzes", params: { quiz: params }, headers: headers
        }.to change { Quiz.count }.by(1)
      end

      it "doesn't send notification" do
        expect {
          post "/api/v1/quizzes", params: { quiz: params }, headers: headers
        }.to change { TelegramNotificationJob.jobs.count }.by(0)
      end
    end

    context "answer option has chat groups" do
      let(:option) { create(:option, :with_chat_group, question: question) }
      let(:params) {
        {
          uuid: "abc",
          user_uuid: user.uuid,
          form_id: form.id,
          quizzed_at: Date.today,
          answers_attributes: [
            {
              uuid: "123",
              question_id: question.id,
              question_code: question.code,
              value: question.options.first.value,
              user_uuid: user.uuid,
              quiz_uuid: "abc"
            },
            {
              uuid: "456",
              question_id: question.id,
              question_code: question.code,
              value: option.value,
              user_uuid: user.uuid,
              quiz_uuid: "abc"
            }
          ]
        }
      }

      it "sends notification to group" do
        expect {
          post "/api/v1/quizzes", params: { quiz: params }, headers: headers
        }.to change { TelegramNotificationJob.jobs.count }.by(1)
      end
    end
  end
end
