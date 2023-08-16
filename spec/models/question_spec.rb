# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id              :bigint           not null, primary key
#  code            :string
#  name            :text
#  type            :string
#  hint            :string
#  display_order   :integer
#  relevant        :string
#  required        :boolean
#  audio           :string
#  passing_score   :integer
#  passing_message :text
#  passing_audio   :string
#  failing_message :text
#  failing_audio   :string
#  form_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  section_id      :uuid
#
require "rails_helper"

RSpec.describe Question, type: :model do
  it { is_expected.to belong_to(:form).optional }
  it { is_expected.to belong_to(:form).optional }
  it { is_expected.to have_many(:options).dependent(:destroy) }
  it { is_expected.to have_many(:criterias).dependent(:destroy) }
end
