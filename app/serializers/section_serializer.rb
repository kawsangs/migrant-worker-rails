# frozen_string_literal: true

# == Schema Information
#
# Table name: sections
#
#  id            :uuid             not null, primary key
#  name          :string
#  form_id       :integer
#  display_order :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class SectionSerializer < ActiveModel::Serializer
  attributes :id, :name, :display_order

  has_many :questions

  class QuestionSerializer < ActiveModel::Serializer
    attributes :id, :code, :name, :type, :hint, :audio_url, :display_order,
               :relevant, :required, :section_id

    has_many :options
    has_many :criterias

    class CriteriaSerializer < ActiveModel::Serializer
      attributes :id, :question_id, :question_code, :operator, :response_value
    end

    class OptionSerializer < ActiveModel::Serializer
      attributes :id, :name, :value, :question_id
    end
  end
end
