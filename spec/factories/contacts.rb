FactoryBot.define do
  factory :contact do
    country
    help_center
    phones { FFaker::PhoneNumber.phone_number }
  end
end
