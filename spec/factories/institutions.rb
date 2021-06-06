# frozen_string_literal: true

# == Schema Information
#
# Table name: institutions
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  kind       :integer          default("gov")
#  address    :text             default("")
#  logo       :string
#  audio      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  code       :string
#
FactoryBot.define do
  factory :institution do
    name { "child help" }
    kind { "ngo" }
  end
end
