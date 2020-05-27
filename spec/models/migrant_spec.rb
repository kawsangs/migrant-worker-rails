# frozen_string_literal: true

# == Schema Information
#
# Table name: migrants
#
#  id           :bigint           not null, primary key
#  full_name    :string
#  age          :string
#  sex          :string
#  phone_number :string
#  voice        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  uuid         :string
#
require 'rails_helper'

RSpec.describe Migrant, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
