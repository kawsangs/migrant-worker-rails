# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id             :bigint           not null, primary key
#  name           :string
#  image          :string
#  audio          :string
#  description    :text
#  type           :string
#  parent_id      :integer
#  lft            :integer          not null
#  rgt            :integer          not null
#  depth          :integer          default(0), not null
#  children_count :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  last           :boolean          default(FALSE)
#  uuid           :string
#  is_video       :boolean
#  hint           :string
#  hint_image     :string
#  hint_audio     :string
#
require "rails_helper"

RSpec.describe Category, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_inclusion_of(:type).in_array(Category::TYPES) }
  it { is_expected.to have_many(:category_images) }
end
