# frozen_string_literal: true

# == Schema Information
#
# Table name: surveys
#
#  id                         :bigint           not null, primary key
#  uuid                       :string
#  user_uuid                  :string
#  form_id                    :integer
#  quizzed_at                 :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  notification_id            :integer
#  notification_occurrence_id :uuid
#
require "rails_helper"

RSpec.describe Survey, type: :model do
  it { is_expected.to belong_to(:user).with_foreign_key("user_uuid").with_primary_key("uuid") }
  it { is_expected.to belong_to(:form) }
  it { is_expected.to belong_to(:notification).optional }
  it { is_expected.to belong_to(:notification_occurrence).optional }
  it { is_expected.to have_many(:survey_answers).with_foreign_key(:survey_uuid).with_primary_key(:uuid).dependent(:destroy) }
end
