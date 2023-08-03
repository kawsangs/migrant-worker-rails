# frozen_string_literal: true

# == Schema Information
#
# Table name: registered_tokens
#
#  id         :bigint           not null, primary key
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :registered_token do
    token       { SecureRandom.hex(10) }
  end
end
