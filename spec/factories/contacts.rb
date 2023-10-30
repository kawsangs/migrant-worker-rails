# frozen_string_literal: true

# == Schema Information
#
# Table name: contacts
#
#  id             :bigint           not null, primary key
#  type           :string           not null
#  value          :string           default("")
#  institution_id :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :contact do
    type { "Contacts::Phone" }
    value { FFaker::PhoneNumber.phone_number }
    institution

    trait :phone do
      type { "Contacts::Phone" }
    end

    trait :facebook do
      type { "Contacts::Facebook" }
      value { "https://www.facebook.com/ilabs" }
    end

    trait :whatsapp do
      type { "Contacts::Whatsapp" }
    end

    trait :messenger do
      type { "Contacts::Messenger" }
    end

    trait :line do
      type { "Contacts::Line" }
    end

    trait :signal do
      type { "Contacts::Signal" }
    end

    trait :telegram do
      type { "Contacts::Telegram" }
    end

    trait :website do
      type { "Contacts::Website" }
    end
  end
end
