# frozen_string_literal: true

# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  code       :string           default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name_km    :string
#
FactoryBot.define do
  factory :country do
    name { FFaker::Name.name }
    code { name.downcase.split(" ").join("_") }

    trait :cambodia do
      name { "Cambodia" }
      code { "km" }
    end

    trait :canada do
      name { "Canada" }
      code { "ca" }
    end
  end
end
