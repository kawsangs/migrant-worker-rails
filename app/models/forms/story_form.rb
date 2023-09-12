# frozen_string_literal: true

# == Schema Information
#
# Table name: forms
#
#  id           :bigint           not null, primary key
#  code         :string
#  name         :string
#  form_type    :string
#  version      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  image        :string
#  audio        :string
#  published_at :datetime
#  description  :text
#
module Forms
  class StoryForm < ::Form
    # Validation
    validates_associated :questions

    def self.policy_class
      StoryFormPolicy
    end
  end
end
