# frozen_string_literal: true

# == Schema Information
#
# Table name: taggings
#
#  id            :bigint           not null, primary key
#  tag_id        :uuid
#  taggable_id   :string
#  taggable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Tagging < ApplicationRecord
  belongs_to :tag, counter_cache: true
  belongs_to :taggable, polymorphic: true
end
