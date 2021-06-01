# frozen_string_literal: true

# == Schema Information
#
# Table name: registered_tokens
#
#  id         :bigint           not null, primary key
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe RegisteredToken, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
