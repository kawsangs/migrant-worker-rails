# frozen_string_literal: true

# == Schema Information
#
# Table name: contacts
#
#  id             :bigint           not null, primary key
#  type           :string           not null
#  value          :string           default("")
#  institution_id :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Contacts::Line < Contact
  def fa
    "fa-brands fa-line"
  end
end
