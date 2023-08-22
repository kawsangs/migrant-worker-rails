# frozen_string_literal: true

# == Schema Information
#
# Table name: visits
#
#  id            :uuid             not null, primary key
#  page_id       :string
#  pageable_id   :string
#  pageable_type :string
#  user_id       :integer
#  device_id     :string
#  visit_date    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :visit do
    visit_date { DateTime.yesterday }
    page
    user
  end
end
