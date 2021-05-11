FactoryBot.define do
  factory :contact do
    type { "Phone" }
    value { FFaker::PhoneNumber.phone_number }
    institution
  end
end
