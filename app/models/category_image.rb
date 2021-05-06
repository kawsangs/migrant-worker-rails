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
class CategoryImage < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :category, optional: true
  before_create :default_name

  def default_name
    self.name ||= File.basename(image.filename, ".*").titleize if image
  end
end
