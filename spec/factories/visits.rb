# frozen_string_literal: true

# == Schema Information
#
# Table name: visits
#
#  id            :uuid             not null, primary key
#  page_id       :string
#  pageable_id   :string
#  pageable_type :string
#  device_id     :string
#  visit_date    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_uuid     :string
#
FactoryBot.define do
  factory :visit do
    visit_date { DateTime.yesterday }
    page
    user
  end
end
