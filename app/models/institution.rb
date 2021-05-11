class Institution < ApplicationRecord
  enum kind: { ngo: 1, gov: 2, other: 3 }
  
  has_many :contacts
  has_many :country_institutions
end
