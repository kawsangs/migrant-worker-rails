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
class Category < ApplicationRecord
  TYPES = %w(Categories::Departure Categories::Safety).freeze

  mount_uploader :image, ImageUploader
  mount_uploader :audio, AudioUploader
  mount_uploader :hint_image, ImageUploader
  mount_uploader :hint_audio, AudioUploader

  has_many :category_images

  validates :name, presence: true
  validates :type, presence: true, inclusion: { in: TYPES }

  acts_as_nested_set counter_cache: :children_count, touch: true

  after_initialize :set_uuid, if: -> { uuid.blank? }

  def self.policy_class
    CategoryPolicy
  end

  def self.types
    TYPES
  end
end
