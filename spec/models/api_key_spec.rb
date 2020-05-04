require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  describe 'before_create #generate_access_token' do
    let(:api_key) { ApiKey.create! }

    it { expect(api_key.access_token).not_to be_nil }
  end
end
