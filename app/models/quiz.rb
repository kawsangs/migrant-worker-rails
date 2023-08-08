# frozen_string_literal: true

# == Schema Information
#
# Table name: quizzes
#
#  id         :bigint           not null, primary key
#  uuid       :string
#  user_uuid  :string
#  form_id    :integer
#  quizzed_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Quiz < ApplicationRecord
  # Association
  belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid"
  belongs_to :form
  has_many :answers, foreign_key: :quiz_uuid, primary_key: :uuid, dependent: :destroy

  # Nested attribute
  accepts_nested_attributes_for :answers, allow_destroy: true
end
