# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  role                   :integer          not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  language_code          :string           default("en")
#  gf_user_id             :integer
#  deleted_at             :datetime
#  actived                :boolean          default(TRUE)
#

FactoryBot.define do
  factory :account do
    email         { FFaker::Internet.email }
    role          { "system_admin" }
    password      { "123456" }
    skip_callback { true }

    trait :allow_callback do
      skip_callback { false }
    end

    trait :system_admin do
      role { "system_admin" }
    end

    trait :admin do
      role { "admin" }
    end

    trait :guest do
      role { "guest" }
    end

    after(:create) do |account, evaluator|
      account.confirm
    end
  end
end
