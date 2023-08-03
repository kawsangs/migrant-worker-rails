# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id            :bigint           not null, primary key
#  title         :string
#  body          :text
#  success_count :integer
#  failure_count :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  published_at  :datetime
#  status        :integer          default("draft")
#
FactoryBot.define do
  factory :notification do
    title { FFaker::Name.name }
    body  { FFaker::Name.name }
  end
end
