# frozen_string_literal: true

# == Schema Information
#
# Table name: options
#
#  id            :bigint           not null, primary key
#  question_id   :integer
#  name          :string
#  value         :string
#  score         :integer
#  alert_audio   :string
#  alert_message :text
#  warning       :boolean
#  recursive     :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  image         :string
#
FactoryBot.define do
  factory :option do
    name  { FFaker::Name.name }
    value { name.downcase.split(" ").join("_") }
    question { create(:question) }

    trait :with_chat_group do
      chat_group_ids { [ create(:chat_group).id ] }
    end
  end
end
