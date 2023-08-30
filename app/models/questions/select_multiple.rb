# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id              :bigint           not null, primary key
#  code            :string
#  name            :text
#  type            :string
#  hint            :string
#  display_order   :integer
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
#  section_id      :uuid
#
module Questions
  class SelectMultiple < Question
    def icon
      "<i class=\'fas fa-list-ul icon\'></i>"
    end

    def label
      "Select Multiple"
    end
  end
end
