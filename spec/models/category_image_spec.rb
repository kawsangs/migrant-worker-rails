# frozen_string_literal: true

# == Schema Information
#
# Table name: category_images
#
#  id            :bigint           not null, primary key
#  name          :string
#  image         :string
#  category_uuid :string
#  category_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "rails_helper"

RSpec.describe CategoryImage, type: :model do
  it { is_expected.to belong_to(:category).optional }
end
