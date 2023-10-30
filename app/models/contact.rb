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
class Contact < ApplicationRecord
  belongs_to :institution

  TYPES = [
    ["Contacts::Phone", "Phone"],
    ["Contacts::Facebook", "Facebook"],
    ["Contacts::Whatsapp", "WhatsApp"],
    ["Contacts::Website", "Website"],
    ["Contacts::Telegram", "Telegram"],
    ["Contacts::Messenger", "Messenger"],
    ["Contacts::Signal", "Signal"],
    ["Contacts::Line", "Line"]
  ]
end
