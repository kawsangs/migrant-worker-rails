# frozen_string_literal: true

# == Schema Information
#
# Table name: registered_tokens
#
#  id         :bigint           not null, primary key
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class RegisteredToken < ApplicationRecord
  validates :token, presence: true
end