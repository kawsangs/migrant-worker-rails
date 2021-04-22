# == Schema Information
#
# Table name: categories
#
#  id             :bigint           not null, primary key
#  name           :string
#  icon           :string
#  image          :string
#  pdf_file       :string
#  audio          :string
#  video          :string
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
  acts_as_nested_set counter_cache: :children_count

  TYPES = %w(Categories::Departure Categories::Safety).freeze

  mount_uploader :icon, FileUploader
  mount_uploader :image, FileUploader
  mount_uploader :pdf_file, FileUploader
  mount_uploader :audio, FileUploader
  mount_uploader :video, FileUploader

  validates :name, presence: true

  def self.policy_class
    CategoryPolicy
  end
end
