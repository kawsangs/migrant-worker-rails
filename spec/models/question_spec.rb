# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id              :bigint           not null, primary key
#  code            :string
#  hint            :string
#  display_order   :integer
#  type            :string
#  name            :text
#  relevant        :string
#  required        :boolean
#  audio           :string
#  passing_score   :integer
#  passing_message :text
#  passing_audio   :string
#  failing_message :text
#  failing_audio   :string
#  form_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require "rails_helper"

RSpec.describe Question, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
