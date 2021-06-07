# frozen_string_literal: true

# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  code       :string           default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name_km    :string
#
require "rails_helper"

RSpec.describe Country, type: :model do
  it { is_expected.to have_db_column(:name) }
  it { is_expected.to validate_presence_of(:name) }

  describe "validates" do
    subject { build(:country) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end


  describe ".query" do
    let!(:cambodia) { create(:country, :cambodia) }
    let!(:canada) { create(:country, :canada) }

    it "queries by name" do
      countries = Country.query("Cam")

      expect(countries.count).to eq 1
    end
  end
end
