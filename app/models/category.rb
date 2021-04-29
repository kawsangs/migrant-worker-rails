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
#
class Category < ApplicationRecord
  TYPES = %w(Categories::Departure Categories::Safety).freeze

  mount_uploader :image, FileUploader
  mount_uploader :audio, FileUploader

  validates :name, presence: true
  validates :type, presence: true, inclusion: { in: TYPES }

  acts_as_nested_set counter_cache: :children_count, touch: true

  def self.policy_class
    CategoryPolicy
  end

  def self.types
    TYPES
  end
end
