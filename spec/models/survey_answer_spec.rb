# frozen_string_literal: true

# == Schema Information
#
# Table name: survey_answers
#
#  id            :bigint           not null, primary key
#  uuid          :string
#  question_id   :integer
#  question_code :string
#  value         :string
#  score         :integer
#  user_uuid     :string
#  survey_uuid   :string
#  voice         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "rails_helper"

RSpec.describe SurveyAnswer, type: :model do
  it { is_expected.to belong_to(:question) }
  it { is_expected.to belong_to(:survey).with_foreign_key("survey_uuid").with_primary_key("uuid").optional }
  it { is_expected.to belong_to(:user).with_foreign_key("user_uuid").with_primary_key("uuid").optional }

  describe "#after_create, notify_telegram_groups" do
    let(:user) { create(:user) }
    let(:form) { create(:form, :with_question_and_options) }
    let(:question) { form.questions.first }

    context "no chat group" do
      let(:params) {
        {
          uuid: "123",
          question_id: question.id,
          question_code: question.code,
          value: question.options.first.value,
          user_uuid: user.uuid,
          survey_uuid: "abc"
        }
      }

      it "doesn't send to telegram group" do
        expect { SurveyAnswer.create(params) }.to change { TelegramNotificationJob.jobs.count }.by(0)
      end
    end

    context "has chat group" do
      let!(:option) { create(:option, :with_chat_group, question: question) }
      let!(:survey) { create(:survey) }
      let!(:params) {
        {
          uuid: "456",
          question_id: question.id,
          question_code: question.code,
          value: option.value,
          user_uuid: user.uuid,
          survey_uuid: survey.uuid
        }
      }

      it "sends to telegram group" do
        expect { SurveyAnswer.create(params) }.to change { TelegramNotificationJob.jobs.count }.by(1)
      end
    end
  end
end
