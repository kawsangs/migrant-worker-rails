# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  code       :string           default("")
#
FactoryBot.define do
  factory :country do
    name { "cambodia" }
  end
end
