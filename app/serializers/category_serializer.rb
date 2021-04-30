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
#
class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image_url, :parent_id, :children

  def children
    ActiveModelSerializers::SerializableResource.new(object.children,  each_serializer: CategorySerializer)
  end
end
