# frozen_string_literal: true

# == Schema Information
#
# Table name: answers
#
#  id            :bigint           not null, primary key
#  uuid          :string
#  question_id   :integer
#  question_code :string
#  value         :string
#  score         :integer
#  user_uuid     :string
#  quiz_uuid     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Answer < ApplicationRecord
  mount_uploader :voice, AudioUploader

  belongs_to :question
  belongs_to :quiz, primary_key: "uuid", foreign_key: "quiz_uuid", optional: true
  belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid", optional: true
end