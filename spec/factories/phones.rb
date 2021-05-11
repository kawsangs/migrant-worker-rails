FactoryBot.define do
  factory :phone do
    value { FFaker::PhoneNumber.phone_number }
  end
end
