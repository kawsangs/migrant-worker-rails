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
    name { "Cambodia" }
  end

  trait :cambodia do
    name { "Cambodia" }
  end

  trait :canada do
    name { "Canada" }
  end
end
