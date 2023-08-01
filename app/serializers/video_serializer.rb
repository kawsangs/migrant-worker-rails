# frozen_string_literal: true

# == Schema Information
#
# Table name: videos
#
#  id              :uuid             not null, primary key
#  name            :string
#  description     :text
#  url             :string
#  display_order   :integer
#  video_author_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class VideoSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :display_order, :updated_at

  belongs_to :video_author
end
