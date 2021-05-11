class Institution < ApplicationRecord
  has_many :contacts
  has_many :country_institutions
end
