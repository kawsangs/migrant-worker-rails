# frozen_string_literal: true

# == Schema Information
#
# Table name: pages
#
#  id             :uuid             not null, primary key
#  code           :string
#  name_km        :string
#  name_en        :string
#  parent_id      :uuid
#  visits_count   :integer
#  lft            :integer          not null
#  rgt            :integer          not null
#  depth          :integer          default(0), not null
#  children_count :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :page do
    name_km  { FFaker::Name.name }
    code     { "abc" }

    trait :with_parent do
      parent_id { create(:page).id }
    end
  end
end
