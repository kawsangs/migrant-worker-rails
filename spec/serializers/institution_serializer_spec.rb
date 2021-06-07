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
require "rails_helper"

RSpec.describe InstitutionSerializer do
  let(:institution) { build(:institution) }

  describe "serializable" do
    subject { described_class.new(institution).as_json }

    it { is_expected.to include(:id, :address, :audio_url,
                                :contacts, :country_institutions,
                                :kind, :logo_url, :name) }
  end
end
