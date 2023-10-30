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
class Contacts::Phone < Contact
  before_save :remove_whitespace

  def fa
    "fas fa-phone"
  end

  private
    def remove_whitespace
      self.value = value.to_s.strip
    end
end
