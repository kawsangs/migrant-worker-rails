# frozen_string_literal: true

# == Schema Information
#
# Table name: registered_tokens
#
#  id          :bigint           not null, primary key
#  token       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  device_id   :string
#  device_type :string
#  app_version :string
#
class RegisteredToken < ApplicationRecord
  validates :token, presence: true

  def self.from_param(params = {})
    return self.find_or_initialize_by(id: params[:id]) if params[:id].present?
    return self.find_or_initialize_by(device_id: params[:device_id]) if params[:device_id].present?

    self.new
  end
end
