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
  belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid"
  belongs_to :form
end
