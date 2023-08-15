# frozen_string_literal: true

# == Schema Information
#
# Table name: sections
#
#  id            :uuid             not null, primary key
#  name          :string
#  form_id       :integer
#  display_order :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :section do
  end
end
