# frozen_string_literal: true

# == Schema Information
#
# Table name: registered_tokens
#
#  id          :bigint           not null, primary key
#  token       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  device_id   :string
#  device_type :string
#  app_version :string
#  device_os   :integer
#
FactoryBot.define do
  factory :registered_token do
    token       { SecureRandom.hex(10) }
    device_id   { SecureRandom.hex(8) }
    device_type { %w(mobile tablet).sample }
    app_version { "1.0.1" }
  end
end
