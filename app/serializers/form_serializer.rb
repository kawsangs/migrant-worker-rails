# frozen_string_literal: true

# == Schema Information
#
# Table name: forms
#
#  id         :bigint           not null, primary key
#  uuid       :string
#  name       :string
#  form_type  :string
#  version    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class FormSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :name, :form_type

  has_many :questions
end
