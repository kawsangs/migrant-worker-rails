class Contact < ApplicationRecord
  belongs_to :country
  belongs_to :help_center
end
