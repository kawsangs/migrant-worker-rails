class Contact < ApplicationRecord
  belongs_to :institution

  TYPES = [
    ['Phone', 'Phone'],
    ['Facebook', 'Facebook'],
    ['Whatsapp', 'WhatsApp'],
  ]
end
