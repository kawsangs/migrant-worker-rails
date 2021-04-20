# frozen_string_literal: true

# == Schema Information
#
# Table name: migrants
#
#  id            :bigint           not null, primary key
#  full_name     :string
#  age           :string
#  sex           :string
#  phone_number  :string
#  voice         :string
#  uuid          :string
#  registered_at :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Migrant < ApplicationRecord
  mount_uploader :voice, ::VoiceUploader

  scope :newest, -> { order("registered_at DESC") }

  def self.filter(params = {})
    scope = all
    scope = scope.where("LOWER(full_name) LIKE ? OR LOWER(phone_number) LIKE ?", "%#{params[:keyword].downcase}%", "%#{params[:keyword].downcase}%") if params[:keyword].present?
    scope
  end
end
