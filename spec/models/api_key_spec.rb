# frozen_string_literal: true

# == Schema Information
#
# Table name: api_keys
#
#  id           :bigint           not null, primary key
#  access_token :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require "rails_helper"

RSpec.describe ApiKey, type: :model do
  describe "before_create #generate_access_token" do
    let(:api_key) { ApiKey.create! }

    it { expect(api_key.access_token).not_to be_nil }
  end
end
