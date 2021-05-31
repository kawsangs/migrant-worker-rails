require 'rails_helper'

RSpec.describe InstitutionSerializer do
  let(:institution) { build(:institution) }

  describe 'serializable' do
    subject { described_class.new(institution).as_json }

    it { is_expected.to include(:id, :address, :audio_url, 
                                :contacts, :country_institutions, 
                                :kind, :logo, :logo_url, :name) }
  end
end
