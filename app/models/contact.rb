class Contact < ApplicationRecord
  belongs_to :institution

  TYPES = [
    ['Phone', 'Phone'],
    ['Facebook', 'Facebook'],
  ]
end
