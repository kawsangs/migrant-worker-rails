# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  uuid          :string
#  full_name     :string
#  sex           :string
#  age           :string
#  audio         :string
#  registered_at :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :user do
  end
end
