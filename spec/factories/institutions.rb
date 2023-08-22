# frozen_string_literal: true

# == Schema Information
#
# Table name: institutions
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  kind          :integer          default(2)
#  address       :text             default("")
#  logo          :string
#  audio         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  code          :string
#  name_km       :string
#  display_order :integer
#
FactoryBot.define do
  factory :institution do
    name { "child help" }
    name_km { FFaker::Name.name }
    kind { "ngo" }

    trait :with_country do
      country_institutions_attributes { [{ country_name: FFaker::Name.name, country_code: FFaker::Name.name.downcase.split(" ").join("")[0..1] }] }
    end
  end
end
