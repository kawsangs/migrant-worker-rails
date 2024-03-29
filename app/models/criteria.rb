# frozen_string_literal: true

# == Schema Information
#
# Table name: criteria
#
#  id             :bigint           not null, primary key
#  question_id    :integer
#  question_code  :string
#  operator       :string
#  response_value :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Criteria < ApplicationRecord
  belongs_to :question

  def self.validation_operators
    ["<", "<=", "=", ">", ">="]
  end
end
