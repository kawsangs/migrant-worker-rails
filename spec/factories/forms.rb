# frozen_string_literal: true

# == Schema Information
#
# Table name: forms
#
#  id           :bigint           not null, primary key
#  code         :string
#  name         :string
#  form_type    :string
#  version      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  image        :string
#  audio        :string
#  published_at :datetime
#
FactoryBot.define do
  factory :form do
    name { FFaker::Name.name }
    form_type { "Forms::StoryForm" }
  end

  factory :survey_form, class: "Forms::SurveyForm" do
    name { FFaker::Name.name }
  end

  factory :story_form, class: "Forms::StoryForm" do
    name { FFaker::Name.name }
  end
end
