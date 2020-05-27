# frozen_string_literal: true

# == Schema Information
#
# Table name: migrants
#
#  id           :bigint           not null, primary key
#  full_name    :string
#  age          :string
#  sex          :string
#  phone_number :string
#  voice        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  uuid         :string
#
FactoryBot.define do
  factory :migrant do
    full_name     { FFaker::Name.name }
    age           { (18..60).to_a.sample }
    sex           {  %w(female male other).sample }
    phone_number  { FFaker::PhoneNumber.phone_number }
  end
end
