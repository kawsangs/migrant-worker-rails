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
require "rails_helper"

RSpec.describe Institution, type: :model do
  it { is_expected.to have_db_column(:name) }
  it { is_expected.to have_db_column(:name_km) }
  it { is_expected.to have_many(:contacts) }
  it { is_expected.to have_many(:country_institutions) }
end
