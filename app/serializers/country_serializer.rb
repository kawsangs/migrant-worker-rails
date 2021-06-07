# frozen_string_literal: true

# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  code       :string           default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name_km    :string
#
class CountrySerializer < ActiveModel::Serializer
  attributes :id, :name, :emoji_flag, :updated_at, :code, :name_km
end
