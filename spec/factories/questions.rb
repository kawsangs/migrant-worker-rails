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
FactoryBot.define do
  factory :question do
    name  { FFaker::Name.name }
    type  { "Questions::SelectOne" }
    form  { create(:form) }

    trait :with_option do
      transient do
        count { 1 }
      end

      after(:create) do |question, evaluator|
        create_list(:option, evaluator.count, question: question)
      end
    end
  end
end
