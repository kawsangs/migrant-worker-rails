class RegisteredToken < ApplicationRecord
  validates :token, presence: true
end
