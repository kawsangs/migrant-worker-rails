FactoryBot.define do
  factory :whatsapp do
    value { FFaker::PhoneNumber.phone_number }
  end
end
