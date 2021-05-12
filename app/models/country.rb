class Country < ApplicationRecord
  has_many :country_institutions
  has_many :institutions, through: :country_institutions
  validates :name, presence: true,
                    uniqueness: { case_sensitive: false }
end
